import 'package:dart_socket_api/dart_persistence_api/collector/class_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/model/dao/dao.dart';
import 'package:dart_socket_api/dart_persistence_api/model/reflector/model_class_mirror.dart';

class DAOCollector extends ClassCollector {
  List<ModelClassMirror<DAO>> collectDAOs() {
    List<ModelClassMirror<DAO>> daos = [];
    for (var dao in findByType(DAO)) {
      try {
        daos.add(ModelClassMirror<DAO>(dao.reflectedType));
      } catch (e) {
        print(e);
        continue;
      }
    }
    return daos;
  }
}
