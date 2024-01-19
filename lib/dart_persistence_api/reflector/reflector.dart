import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(
          // superclassQuantifyCapability,
          subtypeQuantifyCapability,

          declarationsCapability,
          metadataCapability,
          instanceInvokeCapability,
          reflectedTypeCapability,
          invokingCapability,
          typeCapability,
          newInstanceCapability,
          typingCapability,
          typeRelationsCapability,
        );
}

const reflector = Reflector();
