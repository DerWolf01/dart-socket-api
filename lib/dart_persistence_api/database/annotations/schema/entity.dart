import 'package:dart_socket_api/dart_persistence_api/database/annotations/sql_annotation.dart';
import 'package:dart_socket_api/dart_persistence_api/model/reflector/model_class_mirror.dart';

class Entity extends SQLAnnotation {
  const Entity({this.name});

  final String? name;
}
