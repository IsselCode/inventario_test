import 'package:flutter/material.dart';

class PillToggle extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  final Color backgroundColor;
  final Color thumbColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const PillToggle({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    this.backgroundColor = Colors.white,
    this.thumbColor = Colors.black,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black,
  }) : assert(labels.length == 2, "Este diseño está pensado para 2 opciones");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 🔹 Thumb animado
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: selectedIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: thumbColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),

          // 🔹 Texto y taps
          Row(
            children: List.generate(labels.length, (i) {
              final bool isSelected = i == selectedIndex;
              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => onChanged(i),
                  child: Center(
                    child: Text(
                      labels[i],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? selectedTextColor : unselectedTextColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
