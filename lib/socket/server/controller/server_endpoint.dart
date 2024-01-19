import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/socket/interfaces/endpoint.dart';
import 'package:dart_socket_api/socket/server/controller/server_controller.dart';

@reflector
class ServerEndpoint extends IEndpoint {
  const ServerEndpoint(super.path, super.accept);
}
