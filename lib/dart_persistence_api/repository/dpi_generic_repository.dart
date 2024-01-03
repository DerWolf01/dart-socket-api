import 'package:dart_socket_api/dart_persistence_api/database/annotations/sql_types/integer.dart';
import 'package:dart_socket_api/dart_persistence_api/database/database.dart';
import 'package:dart_socket_api/dart_persistence_api/database/utility/sql_command/delete.dart';
import 'package:dart_socket_api/dart_persistence_api/database/utility/sql_command/insert.dart';
import 'package:dart_socket_api/dart_persistence_api/database/utility/sql_command/select/clauses/select_options.dart';
import 'package:dart_socket_api/dart_persistence_api/database/utility/sql_command/select/clauses/where.dart';
import 'package:dart_socket_api/dart_persistence_api/database/utility/sql_command/select/select.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dao/dao.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dao/instance_field.dart';
import 'package:dart_socket_api/dart_persistence_api/model/model.dart';
import 'package:dart_socket_api/dart_persistence_api/model/reflector/model_class_mirror.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/dart_persistence_api/repository/dpi_repository_interface.dart';
import 'package:dart_socket_api/dart_persistence_api/utility/dpi_utility.dart';
import 'package:reflectable/reflectable.dart';

class DPIGenericRepository<T extends DAO> extends DPIUtility {
  T get dao =>
      (reflector.reflectType(T) as ClassMirror).newInstance("", []) as T;
  all() {}

  Future<int> delete() async {
    await dao.callPreDelete();
    var db = await initDB();
    for (var foreignField in dao.foreignFields.entries) {
      dao.set(foreignField.key,
          await foreignField.value.delete(dao.get(foreignField.key), dao));
    }

    var res = await Delete(
            db.db,
            dao,
            Wheres(
                [Where('id', InstanceField<Integer>('id', Integer(), dao.id))]))
        .execute();

    await dao.callPostDelete();
    return res;
  }

  Future<T> save(T dao) async {
    await dao.callPreSave();
    var db = (await SQLiteDatabase.init()).db;
    dao.set("id", (await Insert<T>(db, dao).execute()).id);

    for (var foreignField in dao.foreignFields.entries) {
      dao.set(foreignField.key,
          await foreignField.value.save(dao, dao.get(foreignField.key)));
    }
    print(dao);
    print(dao.id);
    await dao.callPostSave();

    return dao;
  }

  Future<List<Map<String, dynamic>>> queryMap(
      {SelectOptions? selectOptions}) async {
    var mirror = ModelClassMirror<Model>(T);
    var db = (await SQLiteDatabase.init()).db;
    List<Map<String, dynamic>> res = [];
    var daos = (await Select(db, T, selectOptions: selectOptions).execute());
    for (var d in daos) {
      Map<String, List<Map<String, dynamic>>> foreignFields = {};
      for (var foreignKey in mirror.foreignFields.entries) {
        foreignFields[foreignKey.key] =
            await foreignKey.value.queryMap(d["id"] as int);
      }

      res.add(<String, dynamic>{...d, ...foreignFields});
    }
    return res;
  }

  Future<List<T>> query({SelectOptions? selectOptions}) async {
    var mirror = ModelClassMirror<Model>(T);

    return (await queryMap(selectOptions: selectOptions))
        .map((m) => mirror.fromMap(m) as T)
        .toList();
  }

  Future<int> update(T dao) async {
    await dao.callPreUpdate();
    await dao.callPostUpdate();
    return 0;
  }
}
