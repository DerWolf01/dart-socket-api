import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';


@reflector
abstract class IEndpoint {
  const IEndpoint(this.path, this.accept);
  final Type accept;
  final String path;
}
