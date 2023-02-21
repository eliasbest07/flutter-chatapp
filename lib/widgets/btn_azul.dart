import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {
  const BtnAzul({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        child: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )));
  }
}
