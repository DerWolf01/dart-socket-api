import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/dart_persistence_api/model/reflector/model_class_mirror.dart';

class DTOClassMirror<T extends DTO> extends ModelClassMirror<T> {
  DTOClassMirror(super.type);

  fromJSON(String json) => classMirror.newInstance("fromJSON", [json]);
}
