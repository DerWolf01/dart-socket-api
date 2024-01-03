import 'package:dart_socket_api/dart_persistence_api/database/annotations/constraints/normal/normal_constraint.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/sql_types/sql_type.dart';
import 'package:dart_socket_api/dart_persistence_api/database/utility/sql_command/sql_command.dart';
import 'package:dart_socket_api/dart_persistence_api/mirrors/entity_class_mirror.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Create extends SQLCommandUsingType {
  Create(Database db, this.dao, {this.fields}) : super(db, dao.type);

  final EntityClassMirror dao;
  final String? fields;
  String get fieldsString {
    if (fields != null) {
      return fields!;
    }
    return dao
        .getFieldsBySQLType<SQLType>()
        .map((key, value) {
          return MapEntry(
              key,
              "$key ${value.type.toSQL()} ${value.constraints.whereType<NormalSQLConstraint>().map((e) {
                return e.toSQL();
              }).join(' ')}");
        })
        .values
        .join(', ');
  }

  String get primaryKeyConstraints => dao.primaryKeyConstraints.isNotEmpty
      ? "PRIMARY KEY( ${dao.primaryKeyFields.map((e) => toSnakeCase(e.name)).join(', ')} )"
      : '';

  // String get foreingKeyConstraints =>
  //     " ${dao.getFieldsBySQLType<SQLType>().entries.where((entry) => entry.value.constraints.whereType<ForeignKey>().firstOrNull != null).map((value) {
  //       return "{value.type.getConnectionEntity().to}";
  //     })}";
  @override
  execute() async {
    print(
        "CREATE TABLE IF NOT EXISTS $table ( $fieldsString,  $primaryKeyConstraints )");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $table ( $fieldsString,  $primaryKeyConstraints )");
  }
}
