import 'package:dart_socket_api/controllers/endpoint_instance.dart';
import 'package:dart_socket_api/dart_persistence_api/collector/annotated_class.dart';
import 'package:dart_socket_api/middleware/client_middleware.dart';
import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/socket/client/mirror/endpoint_instance.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_controller.dart';
import 'package:dart_socket_api/socket/client/socket/controller/client_endpoint.dart';
import 'package:dart_socket_api/socket/interfaces/controller.dart';
import 'package:dart_socket_api/socket/interfaces/endpoint.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:reflectable/reflectable.dart';
import 'package:path/path.dart' as p;

// abstract class ControllerCLassMirror<
//     ControllerType extends Controller,
//     MiddlewareType extends Middleware,
//     EndpointType extends IEndpoint> extends AnnotatedClass<ControllerType> {
//   ControllerCLassMirror(AnnotatedClass<ControllerType> a)
//       : path = a.annotation.path,
//         super(a.type, a.annotation);
//   final String path;
//   late final List<MiddlewareType> clientMiddlewares;
//   late final Map<String, EndpointType> endpoints;
// }

class ClientControllerClassMirror extends ControllerClassMirror {
  ClientControllerClassMirror(AnnotatedClass<ClientController> a) : super(a);
  // {
  //   endpoints = {};
  //   clientMiddlewares =
  //       classMirror.metadata.whereType<ClientMiddleware>().toList();
  //   for (var member in declarations.values.whereType<MethodMirror>()) {
  //     var endpoint = member.metadata.whereType<ClientEndpoint>().firstOrNull;
  //     if (endpoint == null) {
  //       continue;
  //     }
  //     var endpointClientMiddleware =
  //         member.metadata.whereType<ClientMiddleware>().toList();
  //     print(
  //         "endpoint --> ${p.join(path, endpoint.path)} --> ${member.simpleName}()");

  //     endpoints[endpoint.path] =
  //         EndpointInstance(endpointClientMiddleware, endpoint, member);
  //   }

  //   print({"path": path, endpoints: endpoints});
  // }
}
