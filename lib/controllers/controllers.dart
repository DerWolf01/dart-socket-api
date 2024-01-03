import 'package:dart_socket_api/collector/controller_collector.dart';
import 'package:dart_socket_api/socket/server/mirrors/controller/controller_class_mirror.dart';
import 'package:path/path.dart' as p;

class Controllers {
  static Controllers? _instance;
  Controllers.init() {
    var controllers = ControllerCollector().findControllers();
    endpoints = {};
    print(controllers);
    for (var controller in controllers) {
      print('controlller --> ${controller.path}');
      for (var endpoint in controller.endpoints.entries) {
        print(
            "endpoint --> ${p.join(controller.path, endpoint.value.path)} --> ${endpoint.value.callback.simpleName}()");
      }
    }
    print(endpoints);
  }

  factory Controllers() {
    if (_instance == null) {
      _instance = Controllers.init();
    }

    return _instance!;
  }
  late Map<String, ControllerClassMirror> endpoints;
}
