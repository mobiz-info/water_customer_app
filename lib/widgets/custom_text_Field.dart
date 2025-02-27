import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final Color? color;
  final Color? borderColor;
  final bool border;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final Function? onChangeFunction;
  final TextAlign textAlign;


  final TextEditingController controller;

  const CustomTextField({
    super.key,
    this.icon,
    this.label,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.keyboardType,
    this.border = true,
    required this.controller,
    this.onChangeFunction,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    print("$icon");
    print("$label");
    return Container(
      padding: const EdgeInsets.only(right: 15,bottom: 5,left: 15),
      decoration: border
          ? BoxDecoration(
        borderRadius:borderRadius!=null? BorderRadius.circular(borderRadius!):BorderRadius.circular(22),
        border:border? Border.all(color: borderColor ?? Colors.grey):Border.all(),
      )
          : null,
      child: TextField(
          textAlign: textAlign,
        controller: controller,
        keyboardType: keyboardType!=null ?keyboardType:TextInputType.text,
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
        onChanged: (value) {
          if(onChangeFunction!=null) {
          if (controller.text == "") controller.text = "0";
          onChangeFunction!();
        }}
      ),
    );
  }
}
