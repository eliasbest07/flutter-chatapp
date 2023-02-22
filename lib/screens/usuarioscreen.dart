import 'package:chat_realtime/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({Key? key}) : super(key: key);

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final usuarios = [
    Usuario(email: 'email', nombre: 'elias'),
    Usuario(email: 'email', nombre: 'jose'),

    Usuario(email: 'email', nombre: 'fernando'),
    Usuario(email: 'email', nombre: 'otro'),
    Usuario(email: 'email', nombre: 'online',online: true),

    Usuario(email: 'email', nombre: 'false'),

  ];
   RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nombre Usuario',
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.exit_to_app_outlined,
                  color: Colors.black54)),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: const Icon(Icons.check_circle, color: Colors.green),
              // const Icon(Icons.offline_bolt,color:Colors.red),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header:const WaterDropHeader(complete: Icon(Icons.check, color: Colors.blue),
          waterDropColor: Colors.blue,),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _usuarioTile(usuarios[index]);
              },
              separatorBuilder: (context, index) =>const Divider() ,
              itemCount: usuarios.length),
        ));
  }

  ListTile _usuarioTile(Usuario user) {
    return ListTile(
              title: Text(user.nombre),
              leading: CircleAvatar(
                child: Text(user.nombre.substring(0,2)),
              ),
              trailing: Container( height: 10, width: 10,
               decoration: BoxDecoration(
                color: user.online ? Colors.green[300] : Colors.red,
                shape: BoxShape.circle
               ) , ),
            );
  }
  _cargarUsuarios()async{
      await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
