import 'package:chat_realtime/routes/routes.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
@override
 Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Socket', //Titulo
     initialRoute: 'chat', // inicial rutas y screens.dart
     routes: appRouter,
    );
 }
}