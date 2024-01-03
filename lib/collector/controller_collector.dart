import 'package:dart_socket_api/dart_persistence_api/collector/annotated_class.dart';
import 'package:dart_socket_api/dart_persistence_api/collector/class_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/socket/client/mirror/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/client/socket/controller/controller.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/server/controller/controller.dart';

class ControllerCollector extends ClassCollector {
  List<ControllerClassMirror> findControllers() {
    print("searching for controllers");
    return findByAnnotationTypeArgument<Controller>().map((e) {
      return ControllerClassMirror(AnnotatedClass<Controller>(
          e.reflectedType, e.metadata.whereType<Controller>().first));
    }).toList();
  }

  ControllerClassMirror? findByPath(String path) {
    return findControllers().firstWhere((element) =>
        element.endpoints.containsKey(path.replaceFirst(element.path, '')));
  }

  List<ClientControllerClassMirror> findClientControllers() {
    print("searching for controllers");
    return findByAnnotationTypeArgument<ClientController>().map((e) {
      return ClientControllerClassMirror(AnnotatedClass<Controller>(
          e.reflectedType, e.metadata.whereType<Controller>().first));
    }).toList();
  }

  ClientControllerClassMirror? findClientContrllerByPath(String path) {
    return findClientControllers().firstWhere((element) =>
        element.endpoints.containsKey(path.replaceFirst(element.path, '')));
  }
}
