import 'package:dart_socket_api/dart_persistence_api/dpi.dart';

class DartSocketApi {
  static Future init() async {
    await DPI.init();
    return;
  }
}
