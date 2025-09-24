import 'package:flutter/material.dart';
import 'package:inventario_test/src/controllers/ui/appbar_controller.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class InventoryAppbar extends StatelessWidget implements PreferredSizeWidget {

  const InventoryAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    
    AppbarController inventoryController = context.watch();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        title: Row(
          children: [
            Icon(Symbols.search),
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                onSubmitted: inventoryController.onSearch,
                onChanged: inventoryController.onChangedSearch,
                controller: inventoryController.searchController,
                style: textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Buscar",
                  border: InputBorder.none,
                  hintStyle: textTheme.labelMedium
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (!inventoryController.searching)
          IconButton(
            onPressed: inventoryController.navigateToAddNewProduct,
            icon: Icon(Symbols.add_circle, color: colorScheme.primary,)
          ),
          if (inventoryController.searching)
          IconButton(
            onPressed: inventoryController.clearSearch,
            icon: Icon(Symbols.close, color: Colors.red,)
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
