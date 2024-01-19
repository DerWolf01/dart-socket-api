import 'dart:async';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/message/request/request.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';

abstract class Middlewares {
  static Middlewares? _instance;
  Map<String, List<Middleware>> keyedMiddlewares = {};
  List<Middleware> globalMiddlewares = [];

  void addKeyedMiddleware(String path, Middleware m) {
    keyedMiddlewares[path] ??= [];
    keyedMiddlewares[path]?.add(m);
  }

  void addMiddleware(Middleware m) {
    globalMiddlewares.add(m);
  }

  // FutureOr<bool> callAllPreHandleMiddlewares<SocketType extends TCPSocket>(
  //     ControllerClassMirror? controllerClassMirror,
  //     SocketType client,
  //     Request request);

  // FutureOr<void> callAllPostHandleMiddlewares<SocketType extends TCPSocket>(
  //     ControllerClassMirror? controllerClassMirror,
  //     SocketType client,
  //     Request request);
}
