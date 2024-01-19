import 'dart:async';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/message/fetch_interface.dart';
import 'package:dart_socket_api/message/request/request.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';

class Middleware<SocketType extends TCPSocket> {
  const Middleware({this.preHandle, this.postHandle});
  final Future<bool> Function(TCPSocket client, FetchInterface request)?
      preHandle;
  final FutureOr<bool> Function(TCPSocket client, FetchInterface request)?
      postHandle;

  Future<bool> callPreHandle(TCPSocket client, FetchInterface request) async {
    if (preHandle == null) {
      return true;
    }
    return preHandle!(client, request);
  }

  FutureOr<void> callPostHandle(
      SocketType client, FetchInterface request) async {
    if (postHandle == null) {
      return;
    }
    await postHandle!(client, request);
    return;
  }

  // static FutureOr<bool> callAll(ControllerClassMirror? controllerClassMirror,
  //     TCPClientSession client, FetchInterface request) async {
  //   for (var m in controllerClassMirror?.middlewares ?? <Middleware>[]) {
  //     if ((await m.callPreHandle(client, request)) == false) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }
}
