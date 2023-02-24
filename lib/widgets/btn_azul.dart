import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {
  const BtnAzul({super.key, required this.text, required this.onPressed});
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: Colors.blue,
        
        child: Container(
            width: double.infinity,
            height: 55,
          
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )));
  }
}
