import 'package:flutter/material.dart';

class AuthStructureWidget extends StatelessWidget {

  final Widget child;
  final double percent;

  const AuthStructureWidget({
    super.key,
    required this.child,
    this.percent = 0.8
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width * percent
            ),
            child: child,
          ),
        ),
      )
    );
  }
}
