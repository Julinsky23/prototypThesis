import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesis_prototyp/mobile_views/ios/siri_shortcuts_activation.dart';
import 'package:thesis_prototyp/input_screens/sick_report_page.dart';
import 'package:thesis_prototyp/app_features/speech_to_text_page.dart';
import 'package:thesis_prototyp/input_screens/workingtime_registration_page.dart';
import 'package:thesis_prototyp/app_features/timer.dart';
import 'dart:io';

//Screen for devices with width < 600
class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  _MobileViewState createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  final TimerController _timerController = TimerController();

  @override
  void initState() {
    super.initState();

    //Siri-shortcuts will be registered if iOS operating system has been identified
    if (Platform.isIOS) {
      const MethodChannel('com.thesis_prototyp.siri_shortcuts')
          .setMethodCallHandler((MethodCall call) async {
        if (call.method == 'onSiriShortcut') {
          final activityType = call.arguments['activityType'];
          print("Siri shortcut invoked with activity: $activityType");

          // Processing of the activity types so that the timer can be controlled
          if (activityType == 'com.thesis_prototyp.startWork') {
            print("Siri shortcut invoked: Arbeitstag beginnen");
            _timerController.startTimer(() {
              setState(() {});
            });
          } else if (activityType == 'com.thesis_prototyp.stopTimer') {
            print("Siri shortcut invoked: Arbeitstag beenden");
            _timerController.stopTimer();
          } else if (activityType == 'com.thesis_prototyp.resetTimer') {
            print("Siri shortcut invoked: Arbeitszeit verwerfen");
            _timerController.deleteTimer(() {
              setState(() {});
            });
          }
        }
      });
    } else {
      print("Kein iOS Betriebsystem, daher wird der Siri Shortcut nicht verarbeitet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: const Text('Prototyp Bachelorarbeit'),
          backgroundColor: Colors.blue,
          actions: [
            Visibility(
                visible: Platform.isIOS,
                child:
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> const SettingsPage()),
                    );
                  },
                )),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Row(
                  children: [const Text(
                    'Hallo Max!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SpeechText()),
                        );
                      }, child: const Icon(Icons.volume_up),
                    ),
                  ]),
              const SizedBox(height: 40),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  _buildButton('Arbeitszeit', 'assets/images/Arbeitszeit_Button.png', () {
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
                  _buildButton('Urlaubsantrag', 'assets/images/Urlaubsantrag_Button.png', () {
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
                  _buildButton('Krankmeldung', 'assets/images/Krankmeldung_Button.png', () {
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
              SizedBox(height: 50),
              // Timer on mobile HomePage
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _timerController.formatTime(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _timerController.startTimer(() {
                              setState(() {});
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.lightBlue),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _timerController.stopTimer();
                          });
                        },
                        child: const Icon(Icons.stop, color: Colors.lightBlue),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _timerController.deleteTimer(() {
                              setState(() {});
                            });
                          });
                        },
                        child: const Icon(Icons.delete, color: Colors.lightBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Dein nächster Urlaub:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/Urlaubsanzeige.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
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
            shape: CircleBorder(),
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