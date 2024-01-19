import 'dart:async';

import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/middleware/middlewares.dart';
import 'package:dart_socket_api/message/request/request.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';

class ServerMiddlewares extends Middlewares {
  static ServerMiddlewares? _instance;

  ServerMiddlewares._internal();

  factory ServerMiddlewares() {
    _instance ?? ServerMiddlewares._internal();
    return _instance!;
  }

  @override
  FutureOr<bool> callAllPreHandleMiddlewares<SocketType extends TCPSocket>(
      ControllerClassMirror? controllerClassMirror,
      SocketType client,
      Request request) async {
    for (var m
        in controllerClassMirror?.middlewares ?? <Middleware<SocketType>>[]) {
      if ((await m.callPreHandle(client, request)) == false) {
        return false;
      }
    }
    return true;
  }

  @override
  FutureOr<void> callAllPostHandleMiddlewares<SocketType extends TCPSocket>(
      ControllerClassMirror? controllerClassMirror,
      SocketType client,
      Request request) async {
    for (var m
        in controllerClassMirror?.middlewares ?? <Middleware<SocketType>>[]) {
      await m.callPostHandle(client, request);
    }
  }
}
