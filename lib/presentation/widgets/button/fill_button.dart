import 'package:flutter/material.dart';
import 'package:g_sneaker/src/values/value_manager.dart';

class FilledButtonApp extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final bool isEnable;
  final bool hasShadow;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? paddingButton;

  const FilledButtonApp({
    super.key,
    required this.label,
    this.borderRadius,
    this.color,
    this.textColor,
    this.onPressed,
    this.isEnable = true,
    this.hasShadow = true,
    this.labelStyle,
    this.paddingButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: paddingButton,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius ?? RadiusApp.r0)),
        child: Text(
          label,
          style: labelStyle,
        ),
      ),
    );
  }
}
