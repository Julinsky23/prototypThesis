import 'package:flutter/material.dart';
import 'package:thesis_prototyp/home_page.dart';

//Page for reporting working time
class WorkingtimeRegistration extends StatelessWidget {
  final String activity;
  final String description;
  final String start;
  final String end;

  const WorkingtimeRegistration({
    super.key,
    required this.activity,
    required this.description,
    required this.start,
    required this.end,
});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Block anlegen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: WorkingtimeRegistrationPage(parsedData: {
        'activity': activity,
        'description': description,
        'start':start,
        'end':end,
      },),
    );
  }
}

class WorkingtimeRegistrationPage extends StatefulWidget{
  final Map<String,String> parsedData;

  WorkingtimeRegistrationPage({required this.parsedData});

  @override
  _WorkingtimeRegistrationPageState createState() => _WorkingtimeRegistrationPageState();

}

class _WorkingtimeRegistrationPageState extends State<WorkingtimeRegistrationPage>{
  late TextEditingController _activityController;
  late TextEditingController _descriptionController;
  late TextEditingController _startController;
  late TextEditingController _endController;

  @override
  void initState(){
    super.initState();
    _activityController = TextEditingController(text: widget.parsedData['activity']);
    _descriptionController = TextEditingController(text: widget.parsedData['description']);
    _startController = TextEditingController(text: widget.parsedData['start']);
    _endController = TextEditingController(text: widget.parsedData['end']);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Block anlegen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),),
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
            const Text(
              'AKTIVITÄT (OPTIONAL)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _activityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bitte eingeben',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'BESCHREIBUNG',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>HomePage()),
                );
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
