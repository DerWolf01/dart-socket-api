import 'dart:async';
import 'package:dart_socket_api/socket/client/mirror/controller_class_mirror.dart';
import 'package:dart_socket_api/response/response.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';

class ClientMiddleware {
  const ClientMiddleware(this.callback);
  final FutureOr<bool> Function(TCPClient client, Response request) callback;

  static FutureOr<bool> callAll(
      ClientControllerClassMirror? controllerClassMirror,
      TCPClient client,
      Response request) async {
    for (var m
        in controllerClassMirror?.clientMiddlewares ?? <ClientMiddleware>[]) {
      if ((await m.callback(client, request)) == false) {
        return false;
      }
    }
    return true;
  }
}
