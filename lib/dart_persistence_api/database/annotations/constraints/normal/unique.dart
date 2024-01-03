import 'package:dart_socket_api/dart_persistence_api/database/annotations/constraints/normal/normal_constraint.dart';

class Unique extends NormalSQLConstraint {
  @override
  String toSQL() => "UNIQUE";
}
