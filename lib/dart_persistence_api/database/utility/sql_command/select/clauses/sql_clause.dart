import 'package:dart_socket_api/dart_persistence_api/utility/dpi_utility.dart';

abstract class SQLClause extends DPIUtility {
  SQLClause();
  String toSQL();
}
