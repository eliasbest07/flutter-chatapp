import 'package:chat_realtime/screens/screens.dart';
import 'package:chat_realtime/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/socket_service.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authServer = Provider.of<AuthService>(context, listen: false);
     final socketServer = Provider.of<SocketService>(context,listen: false);
    final autenticado = await authServer.isLoggedIn();
    if (autenticado) {
      //Navigator.pushReplacementNamed(context, 'usuarios');
      socketServer.conectar();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 0),
              pageBuilder: (context, animation, secondaryAnimation) {
                return const UsuarioScreen();
              }));
      // conectar a los socket service
    } else {
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 0),
              pageBuilder: (context, animation, secondaryAnimation) {
                return const LoginScreen();
              }));
    }
  }
}
