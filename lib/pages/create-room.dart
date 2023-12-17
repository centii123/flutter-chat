
import 'package:chat/pages/chatMessages.dart';
import 'package:chat/services/database.service.dart';
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🙋‍♂️ Crear Sala'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '🛋️ Nombre de la sala',
                ),
              ),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: const Text('👻 Crear Sala'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    // Acciones que deseas realizar cuando se envía el formulario
    final name = _nameController.text;
    print(name);
    await createDatabase(name);
    //await MySocketServer().initNetwork();
    print('database creada');
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => chatMessages(roomName: name, ip: 'localhost' )));
  }
}
