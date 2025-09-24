import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventario_test/core/app/enums.dart';

class HistoryTileWidget extends StatelessWidget {

  final InventoryMovementType movementType;
  final String title;
  final DateTime date;
  final int quantity;
  final VoidCallback onLongPress;

  const HistoryTileWidget({
    super.key,
    required this.movementType,
    required this.title,
    required this.date,
    required this.quantity,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;


    return InkWell(
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color : movementType == InventoryMovementType.stockIn
                ? colorScheme.surface
                : Colors.red.withAlpha(40),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Icon(
              movementType == InventoryMovementType.stockIn ?  Icons.inventory_2_outlined : Icons.archive_outlined,
              size: 30,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ),
            const SizedBox(width: 10,),
            Text(DateFormat("dd/MM/yyyy").format(date)),
            const SizedBox(width: 10,),
            SizedBox(
              width: 60,
              child: Text(
                "${quantity.toString()}${quantity > 99999 ? "+" : ""}",
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
