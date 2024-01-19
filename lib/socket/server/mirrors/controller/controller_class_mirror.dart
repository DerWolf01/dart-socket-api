import 'package:dart_socket_api/controllers/endpoint_instance.dart';
import 'package:dart_socket_api/dart_persistence_api/collector/annotated_class.dart';
import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/socket/interfaces/controller.dart';
import 'package:dart_socket_api/socket/interfaces/endpoint.dart';
import 'package:dart_socket_api/socket/server/controller/server_controller.dart';
import 'package:reflectable/reflectable.dart';
import 'package:path/path.dart' as p;

class ControllerClassMirror extends AnnotatedClass<Controller> {
  ControllerClassMirror(AnnotatedClass<Controller> a)
      : super(a.type, a.annotation) {
    path = a.annotation.path;

    endpoints = {};
    middlewares = classMirror.metadata.whereType<Middleware>().toList();
    for (var member in declarations.values.whereType<MethodMirror>()) {
      var endpoint = member.metadata.whereType<IEndpoint>().firstOrNull;
      if (endpoint == null) {
        continue;
      }
      var endpointMiddleWare = member.metadata.whereType<Middleware>().toList();
      print(
          "endpoint --> ${p.join(path, endpoint.path)} --> ${member.simpleName}()");

      endpoints[endpoint.path] =
          EndpointInstance(endpointMiddleWare, endpoint, member);
    }

    print({"path": path, endpoints: endpoints});
  }

  late final String path;

  late final List<Middleware> middlewares;
  late final Map<String, EndpointInstance> endpoints;
}
