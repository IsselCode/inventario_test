import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  const FilledButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon
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
        mainAxisAlignment: icon != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        children: [
          Text(text, style: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimary),),
          if (icon != null)
          Icon(icon)
        ],
      )
    );
  }
}
