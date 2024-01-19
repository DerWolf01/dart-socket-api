import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/socket/interfaces/endpoint.dart';
import 'package:dart_socket_api/socket/server/controller/server_controller.dart';

@reflector
class ClientEndpoint extends IEndpoint {
  const ClientEndpoint(super.path, super.accept);
}
