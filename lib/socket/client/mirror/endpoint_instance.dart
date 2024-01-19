import 'dart:async';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/middleware/client_middleware.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_endpoint.dart';
import 'package:dart_socket_api/socket/interfaces/endpoint.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';
import 'package:reflectable/reflectable.dart';

class ClientEndpointInstance<Accepts extends DTO> extends IEndpoint {
  ClientEndpointInstance(this.middleware, this.endpoint, this.callback)
      : super(endpoint.path, endpoint.accept);

  final List<ClientMiddleware> middleware;
  final ClientEndpoint endpoint;
  final MethodMirror callback;

  FutureOr invoke(TCPClientSession tcpClientSession, Accepts dto) {}
}
