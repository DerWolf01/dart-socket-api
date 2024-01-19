import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_controller.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_endpoint.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';
import 'package:dart_socket_api/test/model/user/user_dto.dart';

@reflector
@ClientController("/user")
class ClientClassController {
  const ClientClassController();
  @ClientEndpoint("/login", UserDTO)
  authenticate(TCPClient client, UserDTO? dto) async {
    
  }
}
