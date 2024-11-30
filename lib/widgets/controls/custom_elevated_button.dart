import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget{
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomElevatedButton({super.key, required this.label, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context){
    return Column(
    children: [
      SizedBox(
        height: 75,
        width: 75,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Image.asset(
            imagePath,
            width: 30,
            height: 30,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize:12),
        ),
      ],
    );
  }
}