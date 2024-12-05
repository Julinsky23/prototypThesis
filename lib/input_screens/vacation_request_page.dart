import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:thesis_prototyp/home_page.dart';
import 'package:thesis_prototyp/widgets/controls/custom_textfield_label.dart';

import '../widgets/controls/custom_back_button.dart';
import '../widgets/controls/custom_text_field.dart';

//Page for reporting Vacation Requests
class VacationRequestPage extends StatefulWidget {
  final String approval;
  final String note;
  final String email;
  final String? selectedVacationType;
  final String? selectedVacationDuration;

  const VacationRequestPage({
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
      appBar: AppBar(title:
      const Text('Neuer Urlaubsantrag'),
        leading: const CustomBackButton(),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CustomTextfieldLabel(text: 'ART DES URLAUBS'),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedOption,
                    hint: Text('Urlaubsart auswählen'),
                    items: optionsVacationType.map((String option){
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState(() => selectedOption = newValue);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedOption2,
                    hint: const Text('Dauer auswählen'),
                    items: optionsVacationDuration.map((String option2){
                      return DropdownMenuItem<String>(
                        value: option2,
                        child: Text(option2),
                      );
                    }).toList(),
                    onChanged: (String? newValue2){
                      setState(() => selectedOption2 = newValue2);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CustomTextfieldLabel(text: 'GENEHMIGUNG ERTEILT DURCH:'),
            CustomTextField(
              controller: _approvalController,
              labelText: 'Bitte eingeben',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const CustomTextfieldLabel(text: 'NOTIZ'),
            CustomTextField(
              controller: _noteController,
              labelText: 'Notiz eingeben',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const CustomTextfieldLabel(text: 'E-MAILS'),
            CustomTextField(
              controller: _emailController,
              labelText: 'E-Mail Adresse eingeben',
              hintText: 'example@domain.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
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