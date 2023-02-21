import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({super.key, required this.route});
  final String route;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text( route == 'register' ? 
          '¿No tienes Cuenta?' : '¿Ya tienes cuenta?' ,
          style:const TextStyle(color: Colors.black54, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
            },
            child: Text( route == 'register' ? 
              'Crea una Cuenta ahora!' : 'Ingresa aquí',
              style: TextStyle(color: Colors.blue[600], fontSize: 18),
            )),
      ],
    );
  }
}
