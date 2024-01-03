import 'dart:core';
import 'dart:io';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';

abstract class TCPSocket {
  const TCPSocket(this.socket);
  final Socket socket;

  write(DTO message) async {
    socket.write(message.toJson());

    await socket.flush();
    print("sent $message ");
  }

  listen(dynamic Function(String data) callback) {
    print("new listener");
    socket.listen((event) {
      print("callback");

      callback(String.fromCharCodes(event));
    });
  }
}
