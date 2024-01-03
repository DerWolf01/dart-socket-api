import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/dart_persistence_api/repository/dpi_generic_repository.dart';
import 'package:dart_socket_api/socket/client/socket/tcp_client.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';
import 'package:dart_socket_api/socket/server/controller/controller.dart';
import 'package:dart_socket_api/socket/server/controller/endpoint.dart';
import 'package:dart_socket_api/response/response.dart';
import 'package:dart_socket_api/test/model/user/user_dao.dart';
import 'package:dart_socket_api/test/model/user/user_dto.dart';

@Controller("/user")
@reflector
class UserController {
  UserController();
  @Endpoint("/login", UserDTO)
  Future<ResponseEntity<UserDTO?>> authenticate(
      TCPClientSession tcpClient, UserDTO userDTO, Response response) async {
    print(tcpClient);
    print("Got user ${userDTO.name}");

    try {
      var dao = userDTO.toDAO() as UserDAO?;
      print(dao);
      if (dao == null) {
        return ResponseEntity(null, false);
      }

      var daoResult = await DPIGenericRepository<UserDAO>().save(dao);

      return ResponseEntity(UserDTO.fromMap(daoResult.toMap()), true);
    } catch (e) {
      print(e);
      return ResponseEntity(null, false);
    }
  }
}
