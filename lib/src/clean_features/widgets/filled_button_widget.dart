import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;

  const FilledButtonWidget({
    super.key,
    required this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return FilledButton(
      style: FilledButton.styleFrom(
        fixedSize: Size(220, 60)
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary),),
          Icon(Icons.arrow_forward)
        ],
      )
    );
  }
}
