import 'dart:async';
import 'package:flutter/material.dart';
import 'package:thesis_prototyp/app_features/timer.dart';

class NavDrawer extends StatefulWidget{
  const NavDrawer({Key? key}) : super(key: key);

  @override
  NavDrawerState createState() => NavDrawerState();
}

class NavDrawerState extends State<NavDrawer>{
  static final NavDrawerState _instance = NavDrawerState._internal();
  factory NavDrawerState() => _instance;
  NavDrawerState._internal();

  final TimerController _timerController = TimerController();


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
          leading: Icon(Icons.house),
          title:Text('Dashboard'),
          onTap: () =>{},
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Mein Bereich'),
          onTap: () =>{},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Einstellungen'),
          onTap: () =>{},
        ),
        SizedBox(height: 200),
        Padding(
          padding: EdgeInsets.only(left: 120.0, right: 0.0, top: 5.0, bottom: 5.0),
          child: Text(
            _timerController.formatTime(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0,vertical: 5.0),
          child: ElevatedButton(
            onPressed: (){

              _timerController.startTimer((){
                setState(() {});
               });
              },
            style:ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
            ),
            child: Icon(Icons.play_arrow),
          ),
        ),
        ElevatedButton(
          onPressed: (){
            _timerController.deleteTimer(() {
              setState(() {
              });
               });
             },
            child: Text('Timer löschen'),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {
            _timerController.stopTimer();
            setState(() {

            });
           },
          child: Text('Timer beenden'),
        ),
      ],
    ),
  );
}
}