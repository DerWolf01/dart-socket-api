import 'package:dart_socket_api/controllers/endpoint_instance.dart';
import 'package:dart_socket_api/dart_persistence_api/collector/annotated_class.dart';
import 'package:dart_socket_api/middleware/client_middleware.dart';
import 'package:dart_socket_api/socket/client/mirror/endpoint_instance.dart';
import 'package:dart_socket_api/socket/server/controller/controller.dart';
import 'package:dart_socket_api/socket/server/controller/endpoint.dart';
import 'package:reflectable/reflectable.dart';
import 'package:path/path.dart' as p;

class ClientControllerClassMirror extends AnnotatedClass<Controller> {
  ClientControllerClassMirror(AnnotatedClass<Controller> a)
      : super(a.type, a.annotation) {
    path = a.annotation.path;

    endpoints = {};
    clientMiddlewares =
        classMirror.metadata.whereType<ClientMiddleware>().toList();
    for (var member in declarations.values.whereType<MethodMirror>()) {
      var endpoint = member.metadata.whereType<Endpoint>().firstOrNull;
      if (endpoint == null) {
        continue;
      }
      var endpointClientMiddleware =
          member.metadata.whereType<ClientMiddleware>().toList();
      print(
          "endpoint --> ${p.join(path, endpoint.path)} --> ${member.simpleName}()");

      endpoints[endpoint.path] =
          ClientEndpointInstance(endpointClientMiddleware, endpoint, member);
    }

    print({"path": path, endpoints: endpoints});
  }

  late final String path;

  late final List<ClientMiddleware> clientMiddlewares;
  late final Map<String, ClientEndpointInstance> endpoints;
}
