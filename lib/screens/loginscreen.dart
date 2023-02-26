import 'package:chat_realtime/helpers/mostrar_alerta.dart';
import 'package:chat_realtime/service/auth_service.dart';
import 'package:chat_realtime/service/socket_service.dart';
import 'package:chat_realtime/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Logo(
                        titulo: 'Messenger',
                      )),
                  _Form(),
                  SizedBox(
                    height: 40,
                  ),
                  Labels(route: 'register'),
                  Text('Terminos y Condiciones de uso')
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final correoController = TextEditingController();
  final claveController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authServer = Provider.of<AuthService>(context);
    final socketServer = Provider.of<SocketService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomInput(
            icono: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: correoController,
          ),
          CustomInput(
            icono: Icons.lock_person_rounded,
            placeholder: 'Password',
            isPassword: true,
            textController: claveController,
          ),
          BtnAzul(
              text: 'Login',
              onPressed: authServer.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOK = await authServer.login(
                          correoController.text.trim(),
                          claveController.text.trim());
                      if (loginOK) {
                        // ir a otra pontalla
                        socketServer.conectar();
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        // mostar alerta
                        mostrarAlerta(context, 'Login Incorrecto',
                            'Revisa tus credenciales');
                      }
                    }),
        ],
      ),
    );
  }
}
