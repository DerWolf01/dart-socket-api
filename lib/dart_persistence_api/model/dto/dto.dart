import 'dart:convert';
import 'package:dart_socket_api/dart_persistence_api/collector/dao_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dao/dao.dart';
import 'package:dart_socket_api/dart_persistence_api/model/model.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';

@reflector
class DTO extends Model {
  DTO(this.id);
  String toJson() => jsonEncode(toMap());
  DTO.fromJSON(String json) : super.fromMap(jsonDecode(json));
  DTO.fromMap(super.map) : super.fromMap();
  int? id;
  DAO? toDAO() => DAOCollector().collectDAOs().firstWhere((element) {
        print(element.simpleName);
        return element.simpleName ==
            runtimeType.toString().replaceAll('DTO', 'DAO');
      }).fromMap(toMap());
}
