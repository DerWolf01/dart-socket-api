import 'dart:io';

import 'package:dart_socket_api/collector/controller_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/middleware/client_middleware.dart';
import 'package:dart_socket_api/middleware/middleware.dart';
import 'package:dart_socket_api/response/response.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';

class TCPClient extends TCPSocket {
  TCPClient(super.socket) {
    print("New client: ${socket.address}:${socket.port}");
    listen((data) async {
      print("client --> $data ");
      await acceptData(data);
    });
  }
  static TCPClient? clientSocket;

  static Future<TCPClient?> connect() async {
    if (clientSocket != null) {
      return clientSocket!;
    }

    try {
      clientSocket = TCPClient(await Socket.connect('localhost', 1335));
    } catch (e) {
      print(e);
    }
    return clientSocket;
  }

  acceptData(String data) async {
    Response request;

    try {
      request = Response.fromJSON(data);
      print(
          "Got request -->  ${request.path} --> ${request.payload?.toJson()}");

      var controller =
          ControllerCollector().findClientContrllerByPath(request.path);
      if (controller == null) {
        return;
      }
      print("client got an request");
      print(request);
      var passedMiddlewares =
          await ClientMiddleware.callAll(controller, this, request);
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
      var isAcceptable = request.payload?.modelClassMirror.classMirror
          .isAssignableTo(reflector.reflectType(endpoint.accept));
      if ((isAcceptable != false && isAcceptable != null) ||
          request.payload?.modelClassMirror.classMirror.reflectedType ==
              endpoint.accept) {
        print("has right type");

        var cInstance = (controller.classMirror.newInstance("", []));
        var mirror = reflector.reflect(cInstance);
        print(mirror);
        try {
          var res = await mirror
                  .invoke(endpoint.callback.simpleName, [this, request.payload])
              as Response;

          print(res);
          print(res.success);
          // write(res);
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
  }
}
