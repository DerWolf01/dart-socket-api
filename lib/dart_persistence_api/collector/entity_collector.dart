import 'package:dart_socket_api/dart_persistence_api/collector/dao_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/database/annotations/schema/entity.dart';
import 'package:dart_socket_api/dart_persistence_api/mirrors/entity_class_mirror.dart';

class EntityCollector extends DAOCollector {
  List<EntityClassMirror> collectEntityDAOs() => collectDAOs()
      .where((element) =>
          element.classMirror.metadata.whereType<Entity>().firstOrNull != null)
      .map((e) => EntityClassMirror(
          e.type, e.classMirror.metadata.whereType<Entity>().first))
      .toList();
}
