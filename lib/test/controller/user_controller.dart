import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/dart_persistence_api/repository/dpi_generic_repository.dart';
import 'package:dart_socket_api/message/response/response.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';
import 'package:dart_socket_api/socket/server/controller/server_controller.dart';
import 'package:dart_socket_api/socket/server/controller/server_endpoint.dart';

import 'package:dart_socket_api/test/model/user/user_dao.dart';
import 'package:dart_socket_api/test/model/user/user_dto.dart';

@ServerController("/user")
@reflector
class UserController {
  UserController();

  @ServerEndpoint("/login", UserDTO)
  Future<ResponseEntity<UserDTO?>> authenticate(
      TCPClientSession tcpClient, UserDTO userDTO) async {
    print(tcpClient);
    print("Got user ${userDTO.name}");
    try {
      print("trying to convert to dao");
      var dao = userDTO.toDAO() as UserDAO?;
      print("Getting UserDAO");
      print("UserDAO -->");
      print(dao);
      if (dao == null) {
        print("no dao");
        return ResponseEntity(null, false);
      }

      var daoResult = await DPIGenericRepository<UserDAO>().save(dao);
      print("saved new user with id: ${daoResult.id}");
      return ResponseEntity(UserDTO.fromMap(daoResult.toMap()), true);
    } catch (e) {
      print("Couldn't create UserDAO");
      print(e);
      return ResponseEntity(null, false);
    }
  }
}
