import 'package:flutter/material.dart';
import 'package:thesis_prototyp/services/app_features/timer_provider.dart';


class NavDrawer extends StatefulWidget{
  const NavDrawer({Key? key}) : super(key: key);

  @override
  NavDrawerState createState() => NavDrawerState();
}

class NavDrawerState extends State<NavDrawer>{
  static final NavDrawerState _instance = NavDrawerState._internal();
  factory NavDrawerState() => _instance;
  NavDrawerState._internal();

  //TEST METHODE
  void refresh(){
    setState(() {});
  }

@override
  Widget build(BuildContext context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: const Text(
            'Companion',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.house),
          title:const Text('Dashboard'),
          onTap: () =>{},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Mein Bereich'),
          onTap: () =>{},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Einstellungen'),
          onTap: () =>{},
        ),
        const SizedBox(height: 200),
        Padding(
          padding: const EdgeInsets.only(left: 120.0, right: 0.0, top: 5.0, bottom: 5.0),
          child: Text(
            TimerProvider.timerController.formatTime(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 5.0),
          child: ElevatedButton(
            onPressed: (){
              TimerProvider.timerController.startTimer((){
                setState(() {

                });
              });
              },
            style:ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: const Icon(Icons.play_arrow),
          ),
        ),
        ElevatedButton(
          onPressed: (){
            TimerProvider.timerController.deleteTimer((){
              setState(() {

              });
            });
             },
            child: const Text('Timer löschen'),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {
            TimerProvider.timerController.stopTimer();
           },
          child: const Text('Timer beenden'),
        ),
      ],
    ),
  );
}
}