import 'dart:convert';

import 'package:dart_socket_api/dart_persistence_api/collector/class_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dto/dto.dart';
import 'package:dart_socket_api/socket/server/mirrors/dto_class_mirror.dart';

class DTOCollector<T extends DTO> extends ClassCollector {
  T? byJSON(String json) {
    try {
      return dtoByName(jsonDecode(json)["type"])?.fromJSON(json);
    } catch (e) {
      return null;
    }
  }

  T? byMap(Map<String, dynamic> map) {
    try {
      return dtoByName(map["type"])?.fromMap(map);
    } catch (e) {
      return null;
    }
  }

  DTOClassMirror<T>? dtoByName(String name) =>
      findByName(name)?.reflectedType != null
          ? DTOClassMirror<T>(findByName(name)!.reflectedType)
          : null;
}
