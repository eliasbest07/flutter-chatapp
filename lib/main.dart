import 'package:chat_realtime/routes/routes.dart';
import 'package:chat_realtime/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
@override
 Widget build(BuildContext context) {
   return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
    ],
     child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Socket', //Titulo
       initialRoute: 'loading', // inicial rutas y screens.dart
       routes: appRouter,
      ),
   );
 }
}