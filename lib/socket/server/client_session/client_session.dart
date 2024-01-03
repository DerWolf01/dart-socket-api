import 'package:dart_socket_api/collector/controller_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/request/request.dart';
import 'package:dart_socket_api/response/response.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';
import 'package:dart_socket_api/test/model/user/user_dto.dart';

class TCPClientSession extends TCPSocket {
  TCPClientSession(super.socket) {
    accept();
  }

  accept() async {
    listen((data) async {
      Request request;

      try {
        request = Request.fromJSON(data);
        print(
            "Got request -->  ${request.path} --> ${request.payload.toJson()}");

        var controller = ControllerCollector().findByPath(request.path);
        if (controller == null) {
          return;
        }
        var passedMiddlewares =
            await Middleware.callAll(controller, this, request);
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
        if (request.payload.modelClassMirror.classMirror
                .isAssignableTo(reflector.reflectType(endpoint.accept)) ||
            request.payload.modelClassMirror.classMirror.reflectedType ==
                endpoint.accept) {
          print("has right type");

          var cInstance = (controller.classMirror.newInstance("", []));
          var mirror = reflector.reflect(cInstance);
          print(mirror);
          try {
            Response res = Response(
                request.path,
                await mirror.invoke(
                        endpoint.callback.simpleName, [this, request.payload])
                    as ResponseEntity);

            print(res);
            print(res.success);
            write(res);
          } catch (e) {
            print(e);
          }
        } else {
          print("Inccompatible data");
        }
      } catch (e) {
        // print(e);
        return;
      }
    });
  }
}
