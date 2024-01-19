import 'dart:isolate';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/constraints/appendable/foreign_key/connection.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/constraints/appendable/foreign_key/one_to_many.dart';
import 'package:dart_socket_api/dart_persistence_api/dpi.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/message/request/request.dart';
import 'package:dart_socket_api/middleware/client_middleware.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_controller.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_endpoint.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';
import 'package:dart_socket_api/socket/server/controller/server_controller.dart';
import 'package:dart_socket_api/socket/server/tcp_server.dart';
import 'package:dart_socket_api/test/controller/client_user_controller.dart';
import 'package:dart_socket_api/test/controller/user_controller.dart';
import 'package:dart_socket_api/test/model/user/user_dao.dart';
import 'package:dart_socket_api/test/model/user/user_dto.dart';
import 'dart:io';

@GlobalQuantifyCapability(r'^[A-Z].*$\i', Reflector())
import 'package:reflectable/reflectable.dart';
@GlobalQuantifyCapability(r'^[A-Z].*$\i', Reflector())
import 'dart_socket_api.reflectable.dart';

void main(List<String> arguments) async {
  initializeReflectable();
  await DPI.init();

  Isolate.spawn((message) async {
    initializeReflectable();
    var server = await TCPServer.init();
  }, "");

  var client = await TCPClient.connect();
  client?.socket.write("Hallo");
  print(client?.socket);
  while (true) {
    var m = stdin.readLineSync();
    await client?.write(Request("/user/login", UserDTO(null, "name")));
  } // Search for classes using annotation

  // libraries.forEach((lk, l) {
  //   l.declarations.forEach((dk, d) {
  //     if(d is ClassMirror) {
  //       ClassMirror cm = d as ClassMirror;
  //       cm.metadata.forEach((md) {
  //         InstanceMirror metadata = md as InstanceMirror;
  //         if(metadata.type == reflectClass(Target) && metadata.getField(#id).reflectee == '/313') {
  //           print('found: ${cm.simpleName}');
  //         }
  //       });
}

class Message extends DTO {
  Message(this.message) : super(0);
  String message;
}
