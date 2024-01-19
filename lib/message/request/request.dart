import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/message/fetch_interface.dart';

@reflector
class Request<Payload extends DTO?> extends FetchInterface<Payload> {
  Request.fromJSON(super.json) : super.fromJSON();
  Request.fromMap(super.map) : super.fromMap();
  Request(this.path, Payload? payload) : super(null, payload);

  late final String path;
}
