import 'package:flutter/material.dart';

class IslandHeader extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final Color? color;
  final Border? border;

  const IslandHeader({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.fromLTRB(17.0, 12.0, 17.0, 17.0),
    this.padding = const EdgeInsets.all(22.0),
    this.borderRadius = 30.0,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    const Color kDarkGreenHeader = Color(0xFF4A6559);

    return Container(
      width: double.infinity,
      height: 157.0, // Fixed height based on Stats/Community menus
      margin: margin,
      padding: padding,
      alignment: Alignment.centerLeft, // Ensure content starts from top-left
      decoration: BoxDecoration(
        color: color ?? kDarkGreenHeader.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(borderRadius),
        border: border, 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
