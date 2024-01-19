import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/message/fetch_interface.dart';
import 'package:dart_socket_api/message/request/request.dart';

class ResponseEntity<Payload extends DTO?> extends FetchInterface<Payload> {
  ResponseEntity(Payload? payload, this.success, {this.message})
      : super(0, payload);
  ResponseEntity.fromMap(super.map) : super.fromMap();
  ResponseEntity.fromJSON(super.json) : super.fromJSON();

  late bool success;
  late String? message;
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
