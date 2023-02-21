import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.titulo});
  final String titulo;
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 150,
      child: Column(
        children: [
          Image.asset('assets/tag-logo.png'),
          const SizedBox(
            height: 20,
          ),
           Text(
            titulo,
            style:const TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}
