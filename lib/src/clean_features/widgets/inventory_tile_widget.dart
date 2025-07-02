import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryTileWidget extends StatelessWidget {

  final String asset;
  final String title;
  final String description;
  final VoidCallback onTap;

  const InventoryTileWidget({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
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
              child: Image.asset(asset, height: 100, width: 100,)
            ),
          ),

          const SizedBox(width: 20,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.bodyLarge,),
                const SizedBox(height: 5,),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
