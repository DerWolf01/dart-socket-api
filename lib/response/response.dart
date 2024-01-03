import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/request/request.dart';

class ResponseEntity<Payload extends DTO?> extends DTO {
  ResponseEntity(this.payload, this.success, {this.message}) : super(0);
  ResponseEntity.fromMap(super.map) : super.fromMap();
  ResponseEntity.fromJSON(super.json) : super.fromJSON();

  late bool success;
  late String? message;
  late Payload? payload;
}

@reflector
class Response<Payload extends DTO?> extends ResponseEntity<Payload> {
  Response(this.path, ResponseEntity<Payload> responseEntity)
      : super(responseEntity.payload, responseEntity.success,
            message: responseEntity.message);
  Response.fromMap(super.map) : super.fromMap();
  Response.fromJSON(super.json) : super.fromJSON();
  late final String path;
}
