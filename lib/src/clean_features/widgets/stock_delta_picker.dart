import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/app/enums.dart';

class StockDeltaPicker extends StatefulWidget {
  final int value;
  final int min;
  final int max;
  final void Function(int value, InventoryMovementType? type) onChanged;

  final bool enabled;

  const StockDeltaPicker({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  State<StockDeltaPicker> createState() => _StockDeltaPickerState();
}

class _StockDeltaPickerState extends State<StockDeltaPicker> {

  bool get _canDec => widget.enabled && (widget.value - 1 >= widget.min);
  bool get _canInc => widget.enabled && (widget.value + 1 <= widget.max);

  InventoryMovementType? _typeFor(int v) {
    if (v > 0) return InventoryMovementType.stockIn;
    if (v < 0) return InventoryMovementType.stockOut;
    return null;
  }

  void _notify(int next) {
    widget.onChanged(next, _typeFor(next));
  }

  void _changeBy(int delta) {
    final next = (widget.value + delta).clamp(widget.min, widget.max);
    if (next != widget.value) _notify(next);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _RoundButton(
          icon: Icons.remove,
          enabled: _canDec,
          color: Colors.red,
          onTap: () => _changeBy(-1),
        ),
        Text(
          '${widget.value}',
          style: textTheme.headlineMedium,
        ),
        _RoundButton(
          icon: Icons.add,
          color: Colors.green,
          enabled: _canInc,
          onTap: () => _changeBy(1),
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool enabled;
  final VoidCallback? onTap;

  const _RoundButton({
    required this.icon,
    required this.enabled,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = enabled ? color : color.withAlpha(100);
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: enabled ? 1 : 0.7,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.white, size: 25),
        ),
      ),
    );
  }
}
