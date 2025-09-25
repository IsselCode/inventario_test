import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryTileWidget extends StatelessWidget {

  final String asset;
  final String title;
  final String description;
  final int stock;
  final VoidCallback onTap;
  final double price;
  final VoidCallback onLongPress;

  const InventoryTileWidget({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
    required this.stock,
    required this.price,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20)
            ),
            height: 120,
            width: 120,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(File(asset))
              )
            ),
          ),

          const SizedBox(width: 20,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(title, style: textTheme.bodyLarge,),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(),
                ),
                Row(
                  spacing: 10,
                  children: [
                    Row(
                      spacing: 5,
                      children: [
                        Icon(Icons.inventory_2_outlined, color: colorScheme.primary ,),
                        Text(stock.toString())
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money_outlined, color: colorScheme.primary ,),
                        Text(price.toStringAsFixed(2))
                      ],
                    )
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
