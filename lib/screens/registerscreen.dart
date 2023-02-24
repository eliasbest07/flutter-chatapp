import 'package:chat_realtime/service/auth_service.dart';
import 'package:chat_realtime/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mostrar_alerta.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                        titulo: 'Register',
                      )),
                  _Form(),
                  SizedBox(
                    height: 40,
                  ),
                  Labels(route: 'login'),
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
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final claveController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authServer = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomInput(
            icono: Icons.account_circle_sharp,
            placeholder: 'Name',
            textController: nombreController,
          ),
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
              text: 'Create',
              onPressed: authServer.isLoading
                  ? null
                  : () async {
                      if (nombreController.text.isEmpty ||
                          correoController.text.isEmpty ||
                          claveController.text.isEmpty) {
                        return;
                      }
                      FocusScope.of(context).unfocus();
                      final registro = await authServer.registrar(
                          nombreController.text,
                          correoController.text,
                          claveController.text);
                      if (registro == true) {
                        print('se registro');
                    Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(context, 'Registro Incorrecto',
                           registro );
                      }
                    }),
        ],
      ),
    );
  }
}
