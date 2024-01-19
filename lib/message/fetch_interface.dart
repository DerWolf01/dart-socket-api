import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';

abstract class FetchInterface<Payload extends DTO?> extends DTO {
  FetchInterface(super.id, this.payload);
  FetchInterface.fromMap(super.map) : super.fromMap();
  FetchInterface.fromJSON(super.json) : super.fromJSON();

  late Payload? payload;
}
