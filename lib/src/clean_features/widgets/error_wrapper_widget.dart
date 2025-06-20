import 'package:flutter/material.dart';

class ErrorWrapper extends StatefulWidget {
  final Widget child;
  final String? Function(String?) validator;
  final TextEditingController controller;

  const ErrorWrapper({
    Key? key,
    required this.child,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  _ErrorWrapperState createState() => _ErrorWrapperState();
}

class _ErrorWrapperState extends State<ErrorWrapper> {
  String? _error;

  void validate() {
    setState(() {
      _error = widget.validator(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: validate,
          child: widget.child,
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _error!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}