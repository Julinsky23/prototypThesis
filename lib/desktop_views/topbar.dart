import 'package:flutter/material.dart';
import 'package:thesis_prototyp/services/app_features/speech_to_text_page.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home Prototyp'),
      backgroundColor: Colors.grey[300],
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SpeechText()),
            );
            print("Spracherkennungsbutton geklickt");
          },
        ),
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            print("Notification Button pressed");
          },
        ),
        IconButton(
          icon: const Icon(Icons.help),
          onPressed: (){
            print("Help button pressed");
          },
        ),
        const Text(
          'Max Mustermann',
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  //returns preferred height of widget & sets it to standard height of AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}