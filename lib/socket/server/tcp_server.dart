import 'dart:io';
import 'package:dart_socket_api/controllers/controllers.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';

class TCPServer {
  TCPServer(this.socket) {
    Controllers();
    startListening();
    print("Started tcp-server: localhost:1335");
  }

  final ServerSocket socket;
  static TCPServer? _instance;

  static Future<TCPServer> init() async {
    _instance ??= TCPServer(await ServerSocket.bind('localhost', 1335));
    return _instance!;
  }

  startListening() async {
    print("Start listening");
    socket.listen((client) {
      print("client: ${client.address.rawAddress}");
      TCPClientSession(client);
    });
    print("started listening");
  }

  final Controllers controllers = Controllers();
}
