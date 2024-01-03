import 'package:dart_socket_api/test/model/user/user_dao.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';

class TCPUserClientSession extends TCPClientSession {
  TCPUserClientSession(super.socket, this.user);
  final UserDAO user;




}
