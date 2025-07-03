import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class InventoryAppbar extends StatelessWidget implements PreferredSizeWidget {

  const InventoryAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        title: Row(
          children: [
            Icon(Symbols.search),
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                style: textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Buscar",
                  border: InputBorder.none,
                  hintStyle: textTheme.labelMedium
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
