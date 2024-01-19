import 'package:dart_socket_api/collector/controller_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/message/response/response.dart';
import 'package:dart_socket_api/middleware/server_middlewares.dart';
import 'package:dart_socket_api/message/request/request.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';

class TCPClientSession extends TCPSocket {
  TCPClientSession(super.socket) {
    accept();
  }

  accept() async {
    listen((data) async {
      print("Server got $data");
      Request request;

      try {
        request = Request.fromJSON(data);
        print(
            "Got request -->  ${request.path} --> ${request.payload?.toJson()}");

        ControllerClassMirror? controller =
            ControllerCollector().findByPath(request.path);
        if (controller == null) {
          return;
        }
        bool passedMiddlewares = await ServerMiddlewares()
            .callAllPreHandleMiddlewares(controller, this, request);
        if (!passedMiddlewares) {
          print("didn't pass middlewares.");
          return;
        }
        var endpointPath = request.path.replaceFirst(controller.path, '');
        print("endpoint-path: $endpointPath");
        var endpoint = controller.endpoints[endpointPath];
        if (endpoint == null) {
          print("Endpoint not found");
          return;
        }
        if (request.payload?.modelClassMirror.classMirror
                    .isAssignableTo(reflector.reflectType(endpoint.accept)) ==
                true ||
            request.payload?.modelClassMirror.classMirror.reflectedType ==
                endpoint.accept) {
          print("has right type");

          var cInstance = (controller.classMirror.newInstance("", []));
          var mirror = reflector.reflect(cInstance);
          print(mirror);
          print(mirror.invokeGetter(endpoint.callback.simpleName));
          try {
            Response res = Response(
                request.path,
                await mirror.invoke(
                        endpoint.callback.simpleName, [this, request.payload])
                    as ResponseEntity);

            print("tcp-client-session sends: $res");
            await write(res);
            print("tcp-client-session sent: $res");
            print(res.path);
            print(res.payload?.toJson());
          } catch (e) {
            print(e);
          }
        } else {
          print("Inccompatible data");
        }
      } catch (e) {
        print(e);
        return;
      }
    });
  }
}
