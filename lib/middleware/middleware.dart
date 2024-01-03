import 'dart:async';

import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:dart_socket_api/request/request.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';

class Middleware {
  const Middleware(this.callback);
  final FutureOr<bool> Function(TCPClientSession client, Request request)
      callback;

  static FutureOr<bool> callAll(ControllerClassMirror? controllerClassMirror,
      TCPClientSession client, Request request) async {
    for (var m in controllerClassMirror?.middlewares ?? <Middleware>[]) {
      if ((await m.callback(client, request)) == false) {
        return false;
      }
    }
    return true;
  }
}
