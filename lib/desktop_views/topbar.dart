import 'package:flutter/material.dart';
import 'package:thesis_prototyp/app_features/speech_to_text_page.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Home Prototyp'),
      backgroundColor: Colors.grey[300],
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SpeechText()),
            );
            print("Spracherkennungsbutton geklickt");
          },
        ),
        IconButton(
          icon: Icon(Icons.language),
          onPressed: () {
            print("Notification Button pressed");
          },
        ),
        IconButton(
          icon: Icon(Icons.help),
          onPressed: (){
            print("Help button pressed");
          },
        ),
        const Text(
          'Max Mustermann',
        ),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}