import 'package:flutter/material.dart';
import 'package:thesis_prototyp/home_page.dart';
import 'package:thesis_prototyp/main.dart';
import 'package:thesis_prototyp/app_features/speech_to_text_page.dart' as stt;

//Page for reporting absence from work
class SickReportPage extends StatefulWidget{
  final String approval;
  final String note;
  final String email;
  final String? selectedOption;
  final String? selectedOption2;

  SickReportPage({
    super.key,
    required this.approval,
    required this.note,
    required this.email,
    this.selectedOption,
    this.selectedOption2,
});

  @override
  _SickReportPageState createState() => _SickReportPageState();
}

class _SickReportPageState extends State<SickReportPage>{
  String? selectedOption;
  String? selectedOption2;
  final List<String> optionsSickReportType = ['Eigene Krankmeldung', 'Krankmeldung eines Kindes'];
  final List<String> optionsSickReportDuration = ['1 Tag', '1/2 Tag'];

  late TextEditingController _approvalController;
  late TextEditingController _noteController;
  late TextEditingController _emailController;

  @override
  void initState(){
    super.initState();
    selectedOption = widget.selectedOption;
    selectedOption2 = widget.selectedOption2;

    _approvalController = TextEditingController(text: widget.approval);
    _noteController = TextEditingController(text: widget.note);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose(){
    _approvalController.dispose();
    _noteController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Neue Krankmeldung'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ART DER KRANKMELDUNG',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedOption,
                    hint: const Text('Art der Krankmeldung auswählen'),
                    items: optionsSickReportType.map((String option){
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState((){
                        selectedOption = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedOption2,
                    hint: const Text('Dauer auswählen'),
                    items: optionsSickReportDuration.map((String option2){
                      return DropdownMenuItem<String>(
                        value: option2,
                        child: Text(option2),
                      );
                    }).toList(),
                    onChanged: (String? newValue2){
                      setState(() {
                        selectedOption2 = newValue2;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'GENEHMIGUNG ERTEILT DURCH:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _approvalController,
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Bitte eingeben',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'NOTIZ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bitte eingeben',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'E-MAILS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-Mail Adresse eingeben',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 8),
                  Text('Absenden'),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}