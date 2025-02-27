import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';


class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function tapFunction;
  final LinearGradient colorGradient;
  bool? gradiant ;

   CustomButton(
      {Key? key,
        required this.buttonText,
        required this.tapFunction,
        required this.colorGradient,
      this.gradiant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tapFunction();
      },
      child: Container(
        // margin: const EdgeInsets.only(top: 20, bottom: 20),
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            gradient: gradiant!=true? null: colorGradient,
          color: CustomColors.accentColor,
          borderRadius: BorderRadius.circular(22),
          border:  Border.all(width: 1,color: CustomColors.white)
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
