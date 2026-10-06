import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void showSnack(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void push(Widget page) {
    Navigator.of(this).push(MaterialPageRoute<void>(builder: (_) => page));
  }
}

extension IntExtensions on int {
  String get asShortCount {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}m';
    }
    if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}k';
    }
    return '$this';
  }
}
