import 'package:flutter/material.dart';
import 'package:flutter_siri_shortcuts/flutter_siri_shortcuts.dart';

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
            SizedBox(height: 20),
            const Text('Siri-Befehle aktivieren:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),),
              const SizedBox(height: 50),
              Text('Zum Starten des Timers:'),
              const SizedBox(height: 40),
              AddToSiriButton(
                title: 'Schichtbeginn',
                id: 'com.vamos.startWork',
                url: 'https://someurl.com',
              ),
            const SizedBox(height: 40),
            AddToSiriButton(
              title: 'Arbeitstag beenden',
              id: 'com.vamos.resetTimer',
              url: 'https://someurl.com',
            ),
            const SizedBox(height: 70),
            Text('Zum Zurücksetzen des Timers:'),
            const SizedBox(height: 40),
            AddToSiriButton(
              title: 'Arbeitszeit verwerfen',
              id: 'com.vamos.resetTimer',
              url: 'https://someurl.com',
            ),
          ],
        ),
      ),
    );
  }
}