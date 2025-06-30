import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

extension StringExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get capitalizeFirstofEach {
    return split(" ").map((str) => str.capitalize).join(" ");
  }
}

extension PushNamed on BuildContext {
  void pushNamed(String route, {Object? arguments}) {
    Navigator.pushNamed(this, route, arguments: {"data": arguments});
  }
}

extension Pop on BuildContext {
  void pop() {
    Navigator.pop(this);
  }
}

extension PushReplacement on BuildContext {
  void pushReplacementNamed(String route) {
    Navigator.pushReplacementNamed(this, route);
  }
}

extension PushAndRemoveUntil on BuildContext {
  void pushNamedAndRemoveUntil(String route) {
    Navigator.pushNamedAndRemoveUntil(this, route, (route) => false);
  }
}

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery {
    return MediaQuery.of(this);
  }
}

extension SizeExtension on BuildContext {
  Size get size {
    return MediaQuery.of(this).size;
  }
}

extension WidthExtension on BuildContext {
  double get width {
    return MediaQuery.of(this).size.width;
  }
}

extension HeightExtension on BuildContext {
  double get height {
    return MediaQuery.of(this).size.height;
  }
}

extension FucusOff on BuildContext {
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}
