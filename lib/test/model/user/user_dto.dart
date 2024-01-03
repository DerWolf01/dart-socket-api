import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';

@reflector
class UserDTO extends DTO {
  UserDTO.fromJSON(super.json) : super.fromJSON();
  UserDTO(super.id, this.name);

  UserDTO.fromMap(super.map) : super.fromMap();
  late String name;
}
