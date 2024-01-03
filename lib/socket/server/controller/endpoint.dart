import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/socket/server/controller/controller.dart';

@reflector
class Endpoint extends Controller {
  const Endpoint(super.path, this.accept);

  final Type accept;
}
