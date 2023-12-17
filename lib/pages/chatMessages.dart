import 'dart:async';

import 'package:chat/class/message-post.dart';
import 'package:chat/pages/home.dart';
import 'package:chat/services/connection.service.dart';
import 'package:flutter/material.dart';

class chatMessages extends StatefulWidget {
  final String roomName;
  final String ip;
  const chatMessages({super.key, required this.roomName, required this.ip});

  @override
  State<chatMessages> createState() => _chatMessagesState();
}

class _chatMessagesState extends State<chatMessages> {
  TextEditingController _messageController = TextEditingController();
  //ScrollController _scrollController = ScrollController();
  List messages = [];
  late Timer _timer;
  var conexion;

  insertMessage(String message) async {
    // 📦 Obtener la base de datos local
    ChatMessage messages = ChatMessage(room: widget.roomName, message: message);
    conexion.emit('insert', messages.toJson());

    // 🔄 Recargar mensajes después de insertar uno nuevo
    await loadMessages();
    //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    print('✉️ Mensaje insertado.');
  }

  @override
  void initState() {
    super.initState();
    conexion = connectionNetwork(widget.ip);
    loadMessages();

    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      loadMessages();
      //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      print('Se ejecutó la función cada 10 segundos');
    });
  }

  loadMessages() async {
    conexion.emit('msgs', widget.roomName);
    conexion.on('msgs', (data) {
      setState(() {
        messages = data.map((map) => '${map['message']}').toList();
      });
    });

    print('✉️ Mensajes cargados: $messages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🗨️ Sala de Chat: ${widget.roomName} '),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _timer.cancel();
            Navigator.pushNamed(context, '/');
          },
        ),
        
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              //controller: _scrollController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                 final reversedIndex = messages.length - 1 - index;
                return ListTile(
                  title: Text(messages[reversedIndex]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) {
                      insertMessage(_messageController.text);
                      _messageController.clear();
                    },
                    decoration: const InputDecoration(
                      hintText: '📝 Escribe un mensaje...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    insertMessage(_messageController.text);
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

