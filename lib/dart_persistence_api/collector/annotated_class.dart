import 'package:dart_socket_api/dart_persistence_api/model/reflector/model_class_mirror.dart';

class AnnotatedClass<A> extends ModelClassMirror {
  AnnotatedClass(super.type, this.annotation);
  final A annotation;
}
