import 'dart:async';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/message/fetch_interface.dart';
import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/middleware/middlewares.dart';
import 'package:dart_socket_api/socket/client/mirror/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';

class ClientMiddlewares extends Middlewares {
  static ClientMiddlewares? _instance;

  ClientMiddlewares._internal();

  factory ClientMiddlewares() {
    _instance ?? ClientMiddlewares._internal();
    return _instance!;
  }

  FutureOr<bool> callAllPreHandleMiddlewares(
      ControllerClassMirror? controllerClassMirror,
      TCPClient client,
      FetchInterface request) async {
    for (var m in controllerClassMirror?.middlewares ?? <Middleware>[]) {
      if ((await m.callPreHandle(client, request)) == false) {
        return false;
      }
    }
    return true;
  }

  FutureOr<void> callAllPostHandleMiddlewares(
      ClientControllerClassMirror? controllerClassMirror,
      TCPClient client,
      FetchInterface request) async {
    for (var m in controllerClassMirror?.middlewares ?? <Middleware>[]) {
      await m.callPostHandle(client, request);
    }
  }
}
