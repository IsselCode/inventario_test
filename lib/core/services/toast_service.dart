import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:toastification/toastification.dart';

class ToastService {

  error(String text) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text("¡Ups!"),
      description: Text(text),
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 4),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: Icon(Symbols.error),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
      showProgressBar: true,
      dragToClose: true,
    );
  }

  success(String text) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text("¡Bien!"),
      description: Text(text),
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 4),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: Icon(Symbols.verified),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
      showProgressBar: true,
      dragToClose: true,
    );
  }

}