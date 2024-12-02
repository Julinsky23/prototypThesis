import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:thesis_prototyp/input_screens/vacation_request_page.dart';
import 'package:thesis_prototyp/input_screens/workingtime_registration_page.dart';
import 'package:thesis_prototyp/input_screens/sick_report_page.dart';
//import 'package:thesis_prototyp/desktop_views/nav_drawer.dart';

//Page for speech recognition and output Page of recognized Words
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
  Timer? _timer;
  late stt.SpeechToText _speech;

  final Map<String, List<String>> keywords = {
    'Krankmeldung' : ['Abwesenheit vermerken'],
    'Urlaubsantrag' : ['Urlaubsantrag', 'Urlaub', 'Ferien'],
    'genehmigungen' : ['genehmigt', 'Bestätigung', 'Genehmigung'],
    'notiz': ['Notiz', 'Bemerkung', 'Kommentar', 'Hinweis'],
    'email': ['e-mail', 'Email', 'Mailadresse','Kontakt'],
  };

  bool containsAny(String text, List<String> words){
    return words.any((word)=>text.contains(word));
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _hasNavigated = false;
    _listen(); //speech recognition starts when page is open
  }

  //starts speech recognition, initializes resources & activates listening
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
          //processes recognized words, removes spaces & replaces abbreviations
          setState((){
            _recognizedText = val.recognizedWords.trim();
            _recognizedText = replaceTextAbbreviations(val.recognizedWords.trim());
            _fullRecognizedText += " " + _recognizedText;
          });

          //text analysis starts after 2 Seconds to ensure complete speech input of User
          _timer?.cancel();
          _timer = Timer(const Duration(seconds: 2), () => _analyzeText());

          //searches for recognized words to execute commands
          if(!_hasNavigated){
            if(_recognizedText.contains("starte")){
              stopListening();
              setState(() => _hasNavigated = true);
              //NavDrawerState().startTimer();

              Navigator.popUntil(context,(route)=>route.isFirst);
            }else if(_recognizedText.contains("Abbruch")){
              stopListening();
              setState(() => _hasNavigated = true);
              Navigator.popUntil(context,(route)=>route.isFirst);
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
                  approval: parsedValues['approval'] ?? '',
                  note: parsedValues['note'] ?? '',
                  email: parsedValues['email'] ?? '',
                  selectedOption: selectedOption,
                  selectedOption2: selectedOption2,
              ));
            }

            if(val.recognizedWords.contains("arbeitsblock")){
              setState(() => _hasNavigated = true);
              var parsedValues = _parseText2(_recognizedText);
              _navigateTo(WorkingtimeRegistration(
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
              approval: parsedValues['approval'] ?? '',
                  note: parsedValues['note'] ?? '',
                  email: parsedValues['email'] ?? '',
                  selectedVacationType: selectedVacationType,
                  selectedVacationDuration: selectedVacationDuration,
              ));
            }
          }
        },
        localeId: "de_DE", //sets language & region to German/y
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

  //replaces "Punkt" with "." to prevent errors
  String replaceTextAbbreviations(String text){
    return text.replaceAll(RegExp(r'\bPunkt\b', caseSensitive: false), '.');
  }

  //extracts information from speech recognition and returns it for workingtime_registration
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
      end = endeMatch.group(1)?.trim() ?? '';
    }

    final aktivitatMatch = aktivitatRegExp.firstMatch(text);
    if(aktivitatMatch != null){
      activity = aktivitatMatch.group(1)?.trim() ?? '';
    }

    final beschreibungMatch = beschreibungRegExp.firstMatch(text);
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

  //checks for keywords & navigates to pages after text has been parsed
  void _analyzeText(){
    if(_hasNavigated) return;

    if(containsAny(_fullRecognizedText, keywords['Krankmeldung']!)){
      _hasNavigated = true;
      var parsedValues = _parseText(_fullRecognizedText);
      _navigateTo(SickReportPage(
          approval: parsedValues['approval'] ?? '',
          note: parsedValues['note'] ?? '',
          email: parsedValues['email'] ?? '',
          ));
    }else if (containsAny(_fullRecognizedText, keywords['Urlaubsantrag']!)) {
      _hasNavigated = true;
      var parsedValues = _parseText(_fullRecognizedText);
      _navigateTo(VacationRequestPage(
        approval: parsedValues['approval'] ?? '',
        note: parsedValues['note'] ?? '',
        email: parsedValues['email'] ?? '',
      ));
    }
  }
  //extracts information from speech recognition and returns it
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

  //stops speech recognition, updates state & navigates to specified page
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

  //User view page of recognized text
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          )
        )
      )
    );
  }


}