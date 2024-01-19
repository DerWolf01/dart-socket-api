import 'package:dart_socket_api/dart_persistence_api/database/annotations/schema/entity.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/sql_types/varchar.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dao/dao.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';

@Entity()
@reflector
class UserDAO extends DAO {
  UserDAO.fromMap(super.map) : super.fromMap();

  @Varchar()
  late String name;
}
