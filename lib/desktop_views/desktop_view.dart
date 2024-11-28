import 'package:flutter/material.dart';
import 'package:thesis_prototyp/input_screens/sick_report_page.dart';
import 'package:thesis_prototyp/input_screens/vacation_request_page.dart';
import 'package:thesis_prototyp/input_screens/workingtime_registration_page.dart';
import 'nav_drawer.dart';
import 'topbar.dart';


//Screen for devices with width >= 600
class DesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const NavDrawer(), //Sidebar
        Expanded(
          child: Scaffold(
            appBar: TopBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Hallo Max!',
                                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _buildButton('Arbeitszeit hinzufügen', 'assets/images/Arbeitszeit_Button.png', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const WorkingtimeRegistration(
                                          start: '',
                                          end: '',
                                          activity: '',
                                          description: '',
                                        ),
                                      ),
                                    );
                                  }),
                                  _buildButton('Neuer Urlaubsantrag', 'assets/images/Urlaubsantrag_Button.png', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VacationRequestPage(
                                          approval: '',
                                          note: '',
                                          email: '',
                                        ),
                                      ),
                                    );
                                  }),
                                  _buildButton('Neue Krankmeldung', 'assets/images/Krankmeldung_Button.png', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SickReportPage(
                                          approval: '',
                                          note: '',
                                          email: '',
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Image.asset(
                                'assets/images/Companion_Monatsuebersicht.png',
                                width: 580,
                                height: 300,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 30),
                              const Text(
                                'Dein nächster Urlaub:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.asset(
                                  'assets/images/Urlaubsanzeige.png',
                                  width: 400,
                                  height: 200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //creates standardized buttons
  Widget _buildButton(String label, String imagePath, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          child: Image.asset(
            imagePath,
            width: 30,
            height: 30,
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}