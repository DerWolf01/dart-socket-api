import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';

@reflector
class Controller {
  const Controller(this.path);
  final String path;
}
