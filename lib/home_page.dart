import 'package:flutter/material.dart';
import 'desktop_views/desktop_view.dart';
import 'mobile_views/mobile_view.dart';

//Implementation of responsive Design
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < 600){
            return MobileView();
          }else{
            return DesktopView();
          }
        },
      ),
    );
  }
}