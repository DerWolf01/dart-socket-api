import 'package:dart_socket_api/dart_persistence_api/collector/annotated_class.dart';
import 'package:dart_socket_api/dart_persistence_api/model/model.dart';
import 'package:dart_socket_api/dart_persistence_api/reflector/reflector.dart';
import 'package:reflectable/reflectable.dart';

class ClassCollector {
  ClassMirror? findByName(String name) =>
      reflector.annotatedClasses.where((element) {
        print(
            "searchring model ${element.simpleName}:$name ${element.simpleName.toString() == name.toString()}");

        return element.simpleName.toString() == name.toString();
      }).firstOrNull;

  List<ClassMirror> findByType(Type type) =>
      reflector.annotatedClasses.where((element) {
        try {
          return element.isAssignableTo(reflector.reflectType(type));
        } catch (e) {
          return false;
        }
      }).toList();

  List<ClassMirror> findByAnnotationTypeArgument<T>() => collectWhere((c) {
        bool ofType = c.metadata.whereType<T>().firstOrNull != null;
        return ofType;
      }).toList();

  static collect() {
    for (var lib in reflector.libraries.entries) {
      print(
          "---------------------------------------------------------------: ${lib.key} :---------------------------------------------------------------");
      print(lib.value);
      for (var dec in lib.value.declarations.entries) {
        try {
          if (dec.value is ClassMirror &&
              (dec.value as ClassMirror)
                  .isAssignableTo(reflector.reflectType(Model))) {
            print(
                "---------------------------------------------------------------: ${dec.key} :---------------------------------------------------------------");

            print(dec.value);
          }
        } finally {}
      }
    }
  }

  static collectWhere(bool Function(ClassMirror classMirror) callback) {
    List<ClassMirror> res = [];
    for (var lib in reflector.libraries.entries) {
      // print(
      //     "---------------------------------------------------------------: ${lib.key} :---------------------------------------------------------------");
      // print(lib.value);
      for (var dec in lib.value.declarations.entries) {
        try {
          if (dec.value is ClassMirror && callback(dec.value as ClassMirror)) {
            print(
                "---------------------------------------------------------------: ${dec.key} :---------------------------------------------------------------");
            print(dec.value.simpleName);
            res.add(dec.value as ClassMirror);
            // print(dec.value);
          }
        } catch (e) {
          print(e);
        }
      }
    }
    return res;
  }
}
