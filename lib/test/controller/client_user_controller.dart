import 'package:dart_socket_api/socket/client/socket/controller/controller.dart';
import 'package:dart_socket_api/socket/client/socket/controller/endpoint.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';
import 'package:dart_socket_api/test/model/user/user_dto.dart';

@ClientController("/user")
class ClientClassController {
  @ClientEndpoint("/login", dynamic)
  authenticate(TCPClient client, UserDTO? dto) async {
    print("client got $dto");
  }
}
