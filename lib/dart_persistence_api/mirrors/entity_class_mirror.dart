import 'package:dart_socket_api/dart_persistence_api/database/annotations/constraints/appendable/foreign_key/foreign_key.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/constraints/appendable/primary_key.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/constraints/constraint.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/schema/entity.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/sql_types/sql_type.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dao/dao.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dao/field.dart';
import 'package:dart_socket_api/dart_persistence_api/model/reflector/model_class_mirror.dart';

class EntityClassMirror<T extends DAO> extends ModelClassMirror<T> {
  EntityClassMirror(super.type, this.entity);

  Entity entity;
  String get table =>
      entity.name ?? toSnakeCase(classMirror.simpleName.replaceAll('DAO', ''));

  Map<String, Field<ST>> getFieldsBySQLType<ST extends SQLType>() {
    Map<String, Field<ST>> res = {};
    for (var dec in declarations.entries) {
      ST? dataTypeInstance;

      for (var meta in dec.value.metadata) {
        if (meta is ST) {
          dataTypeInstance = meta;
          break;
        }
      }

      if (dataTypeInstance != null) {
        res[dec.key] = Field<ST>(dec.key, dataTypeInstance,
            constraints:
                dec.value.metadata.whereType<SQLConstraint>().toList());
      }
    }
    return res;
  }

  Map<String, Field<SQLType>>
      getFieldsBySQLConstraint<SC extends SQLConstraint>() {
    Map<String, Field<SQLType>> res = {};
    for (var field in getFieldsBySQLType<SQLType>().entries) {
      if (field.value.constraints.whereType<SC>().firstOrNull != null) {
        res[field.key] = field.value;
      }
    }
    return res;
  }

  List<Field<SQLType>> get primaryKeyFields =>
      getFieldsBySQLConstraint<PrimaryKey>()
          .values
          .map(
              (e) => Field<SQLType>(e.name, e.type, constraints: e.constraints))
          .toList();

  String get primaryKeyConstraints =>
      "PRIMARY KEY( ${primaryKeyFields.map((e) => e.name).join(', ')}";

  Map<String, ForeignKey> get foreignFields =>
      attributesByAnnotation<ForeignKey>(modelClassMirror.classMirror);
}
