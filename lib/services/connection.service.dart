import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

IO.Socket connectionNetwork(ip) {
  IO.Socket client;
  return client = IO.io('http://$ip:3000',
      OptionBuilder().setTransports(['websocket']).build());
}
