import 'package:flutter/material.dart';
import 'package:flutter_siri_shortcuts/flutter_siri_shortcuts.dart';

//Page to activate shortcuts for Siri
class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Siri-Befehle aktivieren:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),),
              const SizedBox(height: 50),
              const Text('Zum Starten des Timers:'),
              const SizedBox(height: 40),
              AddToSiriButton(
                title: 'Arbeitstag beginnen',
                id: 'com.thesis_prototyp.startWork',
                url: 'http://someurl.com',
              ),
            const SizedBox(height: 50),
            const Text('Zum Stoppen des Timers:'),
            const SizedBox(height: 40),
            AddToSiriButton(
              title: 'Arbeitstag beenden',
              id: 'com.thesis_prototyp.stopTimer',
              url: 'http://someurl.com',
            ),
            const SizedBox(height: 50),
            const Text('Zum Zurücksetzen des Timers:'),
            const SizedBox(height: 40),
            AddToSiriButton(
              title: 'Arbeitstag verwerfen',
              id: 'com.thesis_prototyp.resetTimer',
              url: 'http://someurl.com',
            ),
          ],
        ),
      ),
    );
  }
}