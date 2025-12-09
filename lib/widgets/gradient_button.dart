import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? icon;
  final double height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;
  final List<Color> colors;
  final EdgeInsetsGeometry? padding; 

  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.height = 60.0,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.colors = const [
      Color(0xFFFDD835), // Yellow
      Color(0xFF7CB342), // Green
    ],
    // Default padding applied here
    this.padding = const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 8),
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(40),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius as BorderRadius? ?? BorderRadius.circular(40),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // To wrap content if width is null
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 12),
                ],
                Text(
                  text,
                  style: textStyle ??
                      const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3E2E), // Custom dark text color
                        letterSpacing: 0.5,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (padding != null) {
      return Padding(
        padding: padding!,
        child: buttonContent,
      );
    }

    return buttonContent;
  }
}
