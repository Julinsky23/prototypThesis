import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/controls/custom_textfield_label.dart';

class RecognizedTextPage extends StatelessWidget{
  final String recognizedText;

  const RecognizedTextPage({super.key, required this.recognizedText});

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextfieldLabel(text: 'Spracheingabe:'),
        const SizedBox(height: 20),
        Text(
          recognizedText.isEmpty?"Hier sehen Sie die erkannte Spracheingabe": recognizedText,
          style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
