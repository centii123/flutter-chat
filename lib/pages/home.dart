
import 'package:chat/pages/chatMessages.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/src/socket.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();
  String text = 'hola';

  late Socket conexion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚪 Selecciona o Crea una Sala'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _roomController,
              decoration: const InputDecoration(
                labelText: '🏠 Ingresa el Nombre de la Sala a conectar',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: '📶 Ingresa la ip del celular a conectar',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    var name = _roomController.text;
                    var ip = _ipController.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => chatMessages(roomName: name, ip: ip )));
                  },
                  child: const Text('🚀 Unirse a la Sala'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/connect");
                  },
                  child: const Text('➕ Crear Sala'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
