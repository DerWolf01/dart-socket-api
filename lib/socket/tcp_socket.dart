import 'dart:core';
import 'dart:io';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';

abstract class TCPSocket {
  const TCPSocket(this.socket);
  final Socket socket;

  write(DTO message) async {
    socket.write(message.toJson());

    await socket.flush();
    print("sent ${message.toJson()} ${await socket.done}");

    return;
  }

  listen(dynamic Function(String data) callback) async {
    print("new listener for $runtimeType");
    socket.listen((event) async {
      print("$runtimeType runs callback...");
      print(callback);
      callback(String.fromCharCodes(event));
    });
    print("Set listener for $runtimeType");
  }
}
