import 'package:dart_socket_api/dart_persistence_api/database/annotations/sql_annotation.dart';

abstract class SQLType extends SQLAnnotation {
  const SQLType();
  toSQL();
  genSQLValue<T>(T value);
}
