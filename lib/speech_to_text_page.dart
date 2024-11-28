import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'vacation_request_page.dart';
import 'workingtime_registration_page.dart';
import 'sick_report_page.dart';
import 'nav_drawer.dart';
import 'main.dart';

class SpeechText extends StatefulWidget{
  const SpeechText({super.key});

  @override
  State<SpeechText> createState() => _SpeechTextState();
}

class _SpeechTextState extends State<SpeechText>{
  bool _isListening = false;
  bool _hasNavigated = false;
  String _recognizedText = "";
  String _fullRecognizedText = "";
  Timer? timer;
  late stt.SpeechToText _speech;

  final Map<String, List<String>> keywords = {
    'Krankmeldung' : ['Franz', 'franz'],
    'Urlaubsantrag' : ['Urlaubsantrag', 'Urlaub', 'Ferien'],
    'genehmigungen' : ['genehmigt', 'Bestätigung'],
    'notiz': ['Notiz', 'Bemerkung', 'Kommentar', 'Hinweis'],
    'email': ['e-mail', 'Email', 'Mailadresse','Kontakt'],
  };

  bool containsAny(String text, List<String> words){
    return words.any((word)=>text.contains(word));
  }

  void _listen() async{
    if(!_isListening){
      bool available = await _speech.initialize();
      if(available){
        setState((){
          _isListening = true;
          _hasNavigated = false;
          _fullRecognizedText = "";
        });
        _speech.listen(onResult: (val){
          setState((){
            _recognizedText = val.recognizedWords.trim();
            _recognizedText = replaceTextAbbreviations(val.recognizedWords.trim());
            _fullRecognizedText += " " + _recognizedText;
          });

          _timer?.cancel();
          _timer = Timer(Duration(seconds: 2), () => _analyzeText());

          if(!_hasNavigated){
            if(_recognizedText.contains("starte")){
              stopListening();
              setState(() => _hasNavigated = true);
              NavDrawerState().startTimer();
              Navigator.popUtil(context,(route)=>route.isFirst);
            }

            if(containsAny(_recognizedText, keywords['Krankmeldung']!)){
              setState(() => _hasNavigated = true);
              var parsedValues = _parseText(_recognizedText);
              String? selectedOption;
              String? selectedOption2;

              if(_recognizedText.contains("Kind")){
                selectedOption = "Krankmeldung eines Kindes";
              }else if(_recognizedText.contains("eigene Krankmeldung")){
                selectedOption = "eigene Krankmeldung";
              }

              if(_recognizedText.contains("ein Tag") || _recognizedText.contains("einen Tag") || _recognizedText.contains("1 Tag")){
                selectedOption2 = "1 Tag";
              }else if(_recognizedText.contains("ein halber Tag") || _recognizedText.contains("einen halben Tag") || _recognizedText.contains("1/2 Tage")){
                selectedOption2 = "1/2 Tag";
              }

              _navigateTo(SickReportPage(
                  approval: parsedValues['genehmigung'] ?? '',
                  note: parsedValues['note'] ?? '',
                  email: parsedValues['email'] ?? '',
                  selectedOption: selectedOption,
                  selectedOption2: selectedOption2,
              ));
            }

            if(val.recognizedWords.contains("arbeitsblock")){
              setState(() => _hasNavigated = true);
              var parsedValues = _parseText2(_recognizedText);
              _navigateTo(WorkingtimeRegistrationPage(
                start: parsedValues['start'] ?? '',
                end: parsedValues['end'] ?? '',
                activity: parsedValues['activity'] ?? '',
                description: parsedValues['description'] ?? '',
              ));
            }

            if(_recognizedText.contains("Urlaubsantrag")){
              setState(() => _hasNavigated = true);
              var parsedValues = _parseText(_recognizedText);

              String? selectedVacationType;
              String? selectedVacationDuration;

              if(_recognizedText.contains("Erholungsurlaub")){
                selectedVacationType = "Erholungsurlaub";
              }else if(_recognizedText.contains("Sonderurlaub")){
                selectedVacationType = "Sonderurlaub";
              }

              if(_recognizedText.contains("ein Tag") || _recognizedText.contains("einen Tag") || _recognizedText.contains("1 Tag")){
                selectedVacationDuration = "1 Tag";
              }else if(_recognizedText.contains("ein halber Tag") || _recognizedText.contains("einen halben Tag") || _recognizedText.contains("1/2 Tag")){
                selectedVacationDuration = "1/2 Tag";
              }

              _navigateTo(VacationRequestPage(
              approval: parsedValues['genehmigung'] ?? '',
                  note: parsedValues['notiz'] ?? '',
                  email: parsedValues['email'] ?? '',
                  selectedVacationType: selectedVacationType,
                  selectedVacationDuration: selectedVacationDuration,
              ));
            }
          }
        },
        localeId: "de_DE",
        );
      }
    }else{
      stopListening();
    }
  }

  void stopListening(){
    if(_isListening){
      _speech.stop();
      _timer?.cancel();
      _analyzeText();
      setState(()=> _isListening = false);
    }
  }

  String replaceTextAbbreviations(String text){
    return text.replaceAll(RegExp(r'\bPunkt\b', caseSensitive: false), '.');
  }

  Map<String, String> _parseText2(String text){
    String start = '';
    String end = '';
    String activity = '';
    String description = '';

    final startRegExp = RegExp(r'arbeitsbeginn\s+([A-Za-z\s]+)(?=\s+arbeitsende|aktivität|$)', caseSensitive: false);
    final endeRegExp = RegExp(r'arbeitsende[:\s]*(.*?)(?=\s+beschreibung|$)', caseSensitive: false);
    final aktivitatRegExp = RegExp(r'aktivität[:\s]*(.*?)(?=\s+beschreibung|$)', caseSensitive: false);
    final beschreibungRegExp = RegExp(r'beschreibung[:\s]*(.*?)', caseSensitive: false);

    final startMatch = startRegExp.firstMatch(text);
    if(startMatch!=null){
      start = startMatch.group(1)?.trim() ?? '';
    }

    final endeMatch = endeRegExp.firstMatch(text);
    if(endeMatch!=null){
      ende = endeMatch.group(1)?.trim() ?? '';
    }

    final aktivitatMatch = aktivitatRegExp.firstMatch(text);
    if(aktivitatMatch != null){
      activity = aktivitatMatch.group(1)?.trim() ?? '';
    }

    fiinal beschreibungMatch = beschreibungRegExp.firstMatch(text);
    if(beschreibungMatch != null){
      description = beschreibungMatch.group(1)?.trim() ?? '';
    }

    return{
      'start': start,
      'end': end,
      'activity': activity,
      'description': description,
    };
  }

  void _analyzeText(){
    if(_hasNavigated) return;

    if(containsAny(_fullRecognizedText, keywords['Krankmeldung']!)){
      _hasNavigated = true;
      var parsedValues = parseText(_fullRecognizedText);
      _navigateTo(SickReportPage(
          approval: parsedValues['approval'] ?? '',
          note: parsedValues['note'] ?? '',
          email: parsedValues['email'] ?? '',
          ));
    }
  }

  Map<String, String> _parseText(String text){
    String approval = '';
    String note = '';
    String email = '';

    final genehmigungRegExp = RegExp(r'genehmigt durch\s+([A-Za-z\s]+)(?=\s+Notiz|email|$)', caseSensitive: false);
    final notizRegExp = RegExp(r'Notiz[:\s]*(.*?)(?=\s+email|$)', caseSensitive: false);
    final emailRegExp = RegExp(r'\be-mail\s*([^\s]+@[^\s]+)',caseSensitive: false);

    final genehmigungMatch = genehmigungRegExp.firstMatch(text);
    if(genehmigungMatch != null){
      approval = genehmigungMatch.group(1)?.trim() ?? '';
    }

    final notizMatch = notizRegExp.firstMatch(text);
    if(notizMatch != null){
      note = notizMatch.group(1)?.trim() ?? '';
    }

    final emailMatch = emailRegExp.firstMatch(text);
    if(emailMatch != null){
      email = emailMatch.group(1)?.trim() ?? '';
    }

    note = note.replaceAll(RegExp(r'\s+E-Mail\s+.+', caseSensitive: false), '');

    return{
      'approval': approval,
      'note': note,
      'email': email,
    };


  }

  void _navigateTo(Widget page){
    _speech.stop();
    setState(() {
      _isListening = false;
      _hasNavigated = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Spracheingabe:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                _recognizedText.isEmpty ? "Hier sehen Sie den erkannten Text" : _recognizedText,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          )
        )
      )
    );
  }


}