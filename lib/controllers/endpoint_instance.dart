import 'dart:async';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/socket/interfaces/endpoint.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';
import 'package:reflectable/reflectable.dart';

class EndpointInstance<Accepts extends DTO> extends IEndpoint {
  EndpointInstance(this.middleware, this.endpoint, this.callback)
      : super(endpoint.path, endpoint.accept);

  final List<Middleware> middleware;
  final IEndpoint endpoint;
  final MethodMirror callback;

  FutureOr invoke(TCPClientSession tcpClientSession, Accepts dto) {}
}
