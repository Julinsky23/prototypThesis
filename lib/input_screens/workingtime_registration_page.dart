import 'package:flutter/material.dart';
import 'package:thesis_prototyp/home_page.dart';

import '../widgets/controls/custom_back_button.dart';
import '../widgets/controls/custom_text_field.dart';
import '../widgets/controls/custom_textfield_label.dart';

//Page for reporting working time
class WorkingtimeRegistrationPage extends StatefulWidget {
  final String activity;
  final String description;
  final String start;
  final String end;

  const WorkingtimeRegistrationPage({
    super.key,
    required this.activity,
    required this.description,
    required this.start,
    required this.end,
});

  @override
  _WorkingtimeRegistrationState createState() => _WorkingtimeRegistrationState();

}

class _WorkingtimeRegistrationState extends State<WorkingtimeRegistrationPage>{
  late TextEditingController _activityController;
  late TextEditingController _descriptionController;
  late TextEditingController _startController;
  late TextEditingController _endController;

  @override
  void initState(){
    super.initState();
    _activityController = TextEditingController(text: widget.activity);
    _descriptionController = TextEditingController(text: widget.description);
    _startController = TextEditingController(text: widget.start);
    _endController = TextEditingController(text: widget.end);
  }

  @override
  void dispose(){
    _activityController.dispose();
    _descriptionController.dispose();
    _startController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Block anlegen'),
        leading: const CustomBackButton(),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Arbeitsbeginn',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _endController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Arbeitsende',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CustomTextfieldLabel(text: 'AKTIVITÄT (OPTIONAL)'),
            CustomTextField(
              controller: _activityController,
              labelText: 'E-Mail Adresse eingeben',
              hintText: 'example@domain.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const CustomTextfieldLabel(text: 'BESCHREIBUNG'),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bitte eingeben',
              ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
