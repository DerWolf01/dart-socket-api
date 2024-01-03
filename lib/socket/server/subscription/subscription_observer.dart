import 'package:dart_socket_api/dart_persistence_api/model/reflector/model_class_mirror.dart';
import 'package:dart_socket_api/socket/server/client_session/client_session.dart';

class SubscriptionObserver {
  Map<ModelClassMirror, TCPClientSession> subscriptions = {};
}
