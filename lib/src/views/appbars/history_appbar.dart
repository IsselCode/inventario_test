import 'package:flutter/material.dart';

class HistoryAppbar extends StatelessWidget implements PreferredSizeWidget {

  const HistoryAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      title: Text("Historial del inventario", style: textTheme.bodyLarge,),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
