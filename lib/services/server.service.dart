import 'package:chat/services/database.service.dart';
import 'package:socket_io/socket_io.dart';

class MySocketServer {
  Server server = Server();

  initNetwork() async {
    server.on('connection', (client) {
      print('Cliente conectado: $client');

      client.on('msg', (data) {
        client.emit('msg', data);
      });

      client.on('insert', (data) {
        print('server $data');
        insertMessage(data);
      });

      client.on('msgs', (data) async {
        final dataMessages = await loadMessages(data);
        client.emit('msgs', dataMessages);
      });
    });

    server.listen(3000);

    print('Servidor Socket.IO escuchando en el puerto 3000');
  }

  stopNetwork() async {
    server.close();
  }
}

