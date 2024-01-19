import 'package:dart_socket_api/dart_persistence_api/collector/annotated_class.dart';
import 'package:dart_socket_api/dart_persistence_api/collector/class_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/socket/client/mirror/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_controller.dart';
import 'package:dart_socket_api/socket/interfaces/controller.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/server/controller/server_controller.dart';
import 'package:path/path.dart' as p;

class ControllerCollector extends ClassCollector {
  List<ControllerClassMirror> findControllers() {
    print("searching for controllers");
    return findByAnnotationTypeArgument<ServerController>().map((e) {
      return ControllerClassMirror(AnnotatedClass<ServerController>(
          e.reflectedType, e.metadata.whereType<ServerController>().first));
    }).toList();
  }

  ControllerClassMirror? findByPath(String path) {
    return findControllers().firstWhere((element) =>
        element.endpoints.containsKey(path.replaceFirst(element.path, '')));
  }

  List<ClientControllerClassMirror> findClientControllers() {
    print("searching for controllers");
    return findByAnnotationTypeArgument<ClientController>().map((e) {
      return ClientControllerClassMirror(AnnotatedClass<ClientController>(
          e.reflectedType, e.metadata.whereType<ClientController>().first));
    }).toList();
  }

  ClientControllerClassMirror? findClientControllerByPath(String path) {
    return findClientControllers().where((element) {
      print(element);
      print('controller path ${element.path}');

      // var controllerPath = path;
      // if (controllerPath.endsWith("/")) {
      //   controllerPath = controllerPath.substring(0, controllerPath.length - 1);
      // }
      print("endpoints: ");
      var isEndpoint = element.endpoints.keys.where((endpointKey) {
            return element.path + endpointKey == path;
          }).firstOrNull !=
          null;
      return isEndpoint;
    }).firstOrNull;
  }
}
