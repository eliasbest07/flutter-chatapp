import 'dart:io';

import 'package:chat_realtime/models/mensajes_response.dart';
import 'package:chat_realtime/service/auth_service.dart';
import 'package:chat_realtime/service/chat_service.dart';
import 'package:chat_realtime/service/socket_service.dart';
import 'package:chat_realtime/widgets/burbuja_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late ChatService chatServer;
  late SocketService socketServer;
  late AuthService authServer;
  final _textController = TextEditingController();
  final _focuseNode = FocusNode();
  bool _estaEscribiendo = false;

  List<BurbujaChat> mensajechat = [
    //  BurbujaChat(text: 'text', uid: '123',animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 800))),
    //  BurbujaChat(text: 'text otros', uid: '123a',animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 800))),
  ];
  @override
  void initState() {
    chatServer = Provider.of<ChatService>(context, listen: false);
    socketServer = Provider.of<SocketService>(context, listen: false);
    authServer = Provider.of<AuthService>(context, listen: false);
    socketServer.socket.on('mensaje-personal', _escucharMensaje);
    _cargarHistorial(chatServer.usuarioPara!.uid);
    super.initState();
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await chatServer.getChat(usuarioID);
    print(chat);
    final historial = chat.map((m) => BurbujaChat(
        text: m.mensaje,
        uid: m.de,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 800))
          ..forward()));
    mensajechat.insertAll(0, historial);
    setState(() {
      
    });
  }

  void _escucharMensaje(dynamic data) {
    // print('mensaje $data');
    BurbujaChat mensaje = BurbujaChat(
        text: data['mensaje'],
        uid: data['de'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 800)));
    setState(() {
      mensajechat.insert(0, mensaje);
    });
    // mensajechat.add(mensaje);
    mensaje.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // final chatServer = Provider.of<ChatService>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                maxRadius: 18,
                child: Text(
                  chatServer.usuarioPara!.nombre.substring(0, 2),
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(chatServer.usuarioPara!.nombre,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
              itemCount: mensajechat.length,
              reverse: true,
              itemBuilder: (context, index) {
                return mensajechat[index];
              },
            )),
            const Divider(),
            SizedBox(
              height: 100,
              child: _inputChat(),
            )
          ],
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _estaEscribiendo = true;
              } else {
                _estaEscribiendo = false;
              }
              setState(() {});
            },
            focusNode: _focuseNode,
            decoration:
                const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          )),
          // boton de enviar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isAndroid
                ? IconTheme(
                    data: const IconThemeData(color: Colors.blue),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(
                        Icons.send,
                      ),
                      onPressed: !_estaEscribiendo
                          ? null
                          : () {
                              _handleSubmit(_textController.text.trim());
                            },
                    ),
                  )
                : CupertinoButton(
                    onPressed: () {}, child: const Text('enviar')),
          )
        ],
      ),
    ));
  }

  void _handleSubmit(String text) {
    _focuseNode.requestFocus();
    _estaEscribiendo = false;
    final newMessage = BurbujaChat(
      text: text,
      uid: authServer.nuevoUsuario!.uid,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
    );
    // mensajechat.add(newMessage);
    mensajechat.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {});
    socketServer.emit('mensaje-personal', {
      'de': authServer.nuevoUsuario!.uid,
      'para': chatServer.usuarioPara!.uid,
      'mensaje': text
    });
    _textController.text = '';
  }

  @override
  void dispose() {
    // off del socket
    for (var element in mensajechat) {
      element.animationController.dispose();
    }
    socketServer.socket.off('mensaje-personal');
    super.dispose();
  }
}
