import 'dart:io';

import 'package:dart_socket_api/collector/controller_collector.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:dart_socket_api/message/response/response.dart';
import 'package:dart_socket_api/middleware/client_middleware.dart';
import 'package:dart_socket_api/middleware/client_middlewares.dart';
import 'package:dart_socket_api/middleware/middlewares.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:dart_socket_api/socket/tcp_socket.dart';

class TCPClient extends TCPSocket {
  TCPClient(super.socket) {
    print("New client: ${socket.address}:${socket.port}");
    listen((data) {
      print("client got this data --> $data ");
      acceptData(data);
    });
  }
  static TCPClient? clientSocket;

  static Future<TCPClient?> connect() async {
    try {
      clientSocket ??= TCPClient(await Socket.connect('localhost', 1335));
    } catch (e) {
      print(e);
    }
    return clientSocket;
  }

  acceptData(String data) async {
    Response request;
    print("accepting data...");

    request = Response.fromJSON(data);
    print("Got request -->  ${request.path} --> ${request.payload?.toJson()}");
    print(request.payload);
    var controller =
        ControllerCollector().findClientControllerByPath(request.path);
    if (controller == null) {
      print("ServerController not found");
      print(controller);
      return;
    } else {
      print(controller);

      print("ServerController found");
    }
    print("client got an request");
    print(request);

    var passedMiddlewares = await ClientMiddlewares()
        .callAllPreHandleMiddlewares(
            controller as ControllerClassMirror?, this, request);
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
    } else {
      print("Endpoint found");
    }
    bool? isAcceptable;
    try {
      print(request.payload?.modelClassMirror.classMirror);
      print("endpoint-accepts: ${endpoint.accept}");

      print(
          "payload is typeof: ${request.payload?.modelClassMirror.classMirror.reflectedType}");

      print(request.payload?.modelClassMirror.classMirror
          .isAssignableTo(reflector.reflectType(endpoint.accept)));

      isAcceptable = request.payload?.modelClassMirror.classMirror
          .isAssignableTo(reflector.reflectType(endpoint.accept));
    } catch (e) {
      isAcceptable = false;

      print("couldn't compare types");
      print(e);
    }
    if ((isAcceptable != false && isAcceptable != null) ||
        request.payload?.modelClassMirror.classMirror.reflectedType ==
            endpoint.accept) {
      print("has right type");

      var cInstance = (controller.classMirror.newInstance("", []));
      var mirror = reflector.reflect(cInstance);
      print(mirror);
      try {
        var res = await mirror
            .invoke(endpoint.callback.simpleName, [this, request.payload]);
        print(res);
      } catch (e) {
        print("tcp-client: couldn'thandle data.");
        print(e);
        return;
      }
      await ClientMiddlewares()
          .callAllPostHandleMiddlewares(controller, this, request);

      // write(res);
    } else {
      print("Inccompatible data");
    }
  }
}
