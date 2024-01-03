import 'dart:async';

import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/middleware/client_middleware.dart';

import 'package:dart_socket_api/socket/server/client_session/client_session.dart';
import 'package:dart_socket_api/socket/server/controller/endpoint.dart';
import 'package:reflectable/reflectable.dart';

class ClientEndpointInstance<Accepts extends DTO> extends Endpoint {
  ClientEndpointInstance(this.middleware, this.endpoint, this.callback)
      : super(endpoint.path, endpoint.accept);

  final List<ClientMiddleware> middleware;
  final Endpoint endpoint;
  final MethodMirror callback;

  FutureOr invoke(TCPClientSession tcpClientSession, Accepts dto) {}
}