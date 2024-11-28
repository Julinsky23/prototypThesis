import 'package:flutter/material.dart';
import 'desktop/desktop_view.dart';
import 'mobile_view.dart';

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