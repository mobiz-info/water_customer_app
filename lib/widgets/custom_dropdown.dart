import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Color? color;
  final Color? borderColor;
  final bool border;
  final double? borderRadius;
  final List<DropdownMenuItem<String>> items;
  final RxString selectedValue;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    this.label,
    this.icon,
    this.color,
    this.borderColor,
    this.border = true,
    this.borderRadius,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: border
          ? BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 22),
        border: Border.all(color: borderColor ?? Colors.grey),
      )
          : null,
      child: Obx(
            () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            hint: Text(label ?? '', style: TextStyle(color: color)),
            icon: icon != null ? Icon(icon, color: color) : null,
            items: items,
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            isExpanded: true,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
