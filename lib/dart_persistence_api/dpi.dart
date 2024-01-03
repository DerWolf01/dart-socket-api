import 'package:dart_socket_api/dart_persistence_api/collector/class_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/collector/entity_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/database/database.dart';
import 'package:dart_socket_api/dart_persistence_api/database/utility/sql_command/create.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DPI extends ClassCollector {
  static init() async {
    await SQLiteDatabase.init();
    await createTables();
  }

  static createTables() async {
    var db = SQLiteDatabase.init();
    for (var entity in EntityCollector().collectEntityDAOs()) {
      await Create((await db).db, entity).execute();
    }
  }
}
