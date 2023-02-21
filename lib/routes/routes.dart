import 'package:chat_realtime/screens/screens.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)>  appRouter = {
  'usuarios': ( _ ) => const UsuarioScreen(),
  'chat': ( _ ) => const ChatScreen(),
  'login': ( _ ) => const LoginScreen(),
  'register': ( _ ) => const RegisterScreen(),
  'loading': ( _ )=> const LoadingScreen()
};
