import 'package:dart_socket_api/test/model/user/user_dao.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';

class TCPClientSession extends TCPSocket {
  TCPClientSession(super.socket) {
    authenticate();
  }

  authenticate() {
    listen((data) {
      if (data.isEmpty) {
        socket.close();
        return;
      }

      print("Got $data from ${socket.address.address}");
    });
  }
}
