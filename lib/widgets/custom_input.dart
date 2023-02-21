import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({super.key, required this.icono, required this.placeholder, required this.textController,  this.keyboardType = TextInputType.text,  this.isPassword = false});
  final IconData icono;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: TextField(
          
          controller: textController,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              prefixIcon: Icon(icono),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: placeholder),
        ));
  }
}
