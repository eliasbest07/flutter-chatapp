import 'dart:io';

import 'package:chat_realtime/widgets/burbuja_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focuseNode = FocusNode();
  bool _estaEscribiendo = false;

  List<BurbujaChat> mensajechat = [
    //  BurbujaChat(text: 'text', uid: '123',animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 800))),
    //  BurbujaChat(text: 'text otros', uid: '123a',animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 800))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: const [
              CircleAvatar(
                maxRadius: 18,
                child: Text(
                  'te',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text('test 1 ',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
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
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
    );
    // mensajechat.add(newMessage);
    mensajechat.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {});
    _textController.text = '';
  }

  @override
  void dispose() {
    // off del socket
    for (var element in mensajechat) {
      element.animationController.dispose();
    }
    super.dispose();
  }
}
