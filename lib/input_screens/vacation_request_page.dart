import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../home_page.dart';
import '../main.dart';

class VacationRequestPage extends StatefulWidget {
  final String approval;
  final String note;
  final String email;
  final String? selectedVacationType;
  final String? selectedVacationDuration;

  VacationRequestPage({
    required this.approval,
    required this.note,
    required this.email,
    this.selectedVacationType,
    this.selectedVacationDuration,
  });


  @override
  _VacationRequestState createState() => _VacationRequestState();
}

class _VacationRequestState extends State<VacationRequestPage>{
  String? selectedOption;
  String? selectedOption2;
  final List<String> optionsVacationType = ['Erholungsurlaub', 'Sonderurlaub'];
  final List<String> optionsVacationDuration = ['1 Tag', '1/2 Tag'];

  late TextEditingController _approvalController;
  late TextEditingController _noteController;
  late TextEditingController _emailController;

  @override
  void initState(){
    super.initState();
    selectedOption = widget.selectedVacationType;
    selectedOption2 = widget.selectedVacationDuration;

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
      appBar: AppBar(title: Text('Neuer Urlaubsantrag')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ART DES URLAUBS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedOption,
                    hint: Text('Urlaubsart auswählen'),
                    items: optionsVacationType.map((String option){
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState((){
                        selectedOption = newValue; //Zustand aktualisieren
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedOption2,
                    hint: Text('Dauer auswählen'),
                    items: optionsVacationDuration.map((String option2){
                      return DropdownMenuItem<String>(
                        value: option2,
                        child: Text(option2),
                      );
                    }).toList(),
                    onChanged: (String? newValue2){
                      setState((){
                        selectedOption2 = newValue2;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            const Text(
              'GENEHMIGUNG ERTEILT DURCH: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _approvalController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bitte eingeben',
              ),
            ),
            SizedBox(height: 20),
            const Text(
              'NOTIZ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-Mail Adresse eingeben',
              ),
            ),
            SizedBox(height: 20),
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
                Text('Anlegen'),
              ],),
            ),
          ],
        ),
      ),
    );
  }
  }