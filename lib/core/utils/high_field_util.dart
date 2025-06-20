import 'dart:async';

import 'package:flutter/material.dart';

void highFieldUtil(BuildContext context, GlobalKey textFieldKey) {
  final RenderBox renderBox = textFieldKey.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);
  final size = renderBox.size;

  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          left: offset.dx - 4,
          top: offset.dy - 4,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width + 8,
              height: size.height + 8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red.shade300, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Overlay.of(context)!.insert(overlayEntry);

  // Elimina el efecto después de 1 segundo.
  Timer(Duration(seconds: 1), () => overlayEntry.remove());
}