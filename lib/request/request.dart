import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';

@reflector
class Request extends DTO {
  Request.fromJSON(super.json) : super.fromJSON();
  Request.fromMap(super.map) : super.fromMap();
  Request(this.path, this.payload) : super(null);

  late final String path;

  late final DTO payload;
}
