import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/socket/interfaces/controller.dart';
import 'package:dart_socket_api/socket/server/controller/server_controller.dart';

@reflector
class ClientController extends Controller {
  const ClientController(super.path);
}
