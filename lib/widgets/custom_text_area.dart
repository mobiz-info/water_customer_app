import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final Color? color;
  final Color? borderColor;
  final bool border;
  final double? borderRadius;
  final TextInputType? keyboardType;

  final TextEditingController controller;

  const CustomTextArea({
    super.key,
    this.icon,
    this.label,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.keyboardType,
    this.border = true,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    print("$icon");
    print("$label");
    return Container(
      padding: const EdgeInsets.only(right: 15, bottom: 5, left: 15),
      decoration: border
          ? BoxDecoration(
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : BorderRadius.circular(22),
        border: border
            ? Border.all(color: borderColor ?? Colors.grey)
            : Border.all(),
      )
          : null,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        maxLines: 10, // Allows multiple lines
        minLines: 8, // Minimum number of lines to display
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: color) : null,
          labelText: label,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: color,
              fontFamily: 'Poppins'),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
