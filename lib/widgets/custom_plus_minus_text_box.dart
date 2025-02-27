import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';

class CustomPlusMinusTextBox extends StatelessWidget {
  final double width;
  final Function minusFunction;
  final Function plusFunction;
  final Function onChangeFunction;
  final TextEditingController textController;

  const CustomPlusMinusTextBox(
      {super.key,
      required this.width,
      required this.minusFunction,
      required this.plusFunction,
      required this.onChangeFunction,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: CustomColors.containerBorder,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              textController.text = (int.parse(textController.text) - 1) <= 0
                  ? '0'
                  : (int.parse(textController.text) - 1).toString();
              minusFunction();
            },
            child: Container(
                alignment: Alignment.topCenter,
                // padding: EdgeInsets.all(5),
                //  margin: EdgeInsets.symmetric(horizontal: 5),
                height: width * .08,
                width: width * .08,
                decoration: BoxDecoration(
                  color: CustomColors.buttonGray,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: CustomColors.containerBorder,
                    width: 1,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1), // Shadow color
                  //     spreadRadius: 1, // Spread radius
                  //     blurRadius: 5, // Blur radius
                  //     offset: Offset(0, 5), // Shadow position (x, y)
                  //   ),
                  // ],
                ),
                child: Text(
                  "-",
                  style: symbolStyle,
                )),
          ),
          Expanded(
            child: SizedBox(
             // width: width * .132,
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: grayTextStyle2,
                onChanged: (value) {
                  if (textController.text == "") textController.text = "0";
                  onChangeFunction();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  isDense: true,
                  border: InputBorder.none,
                  // border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              textController.text =
                  (int.parse(textController.text) + 1).toString();
              plusFunction();
            },
            child: Container(
                //padding: EdgeInsets.all(5),
                // margin: EdgeInsets.symmetric(horizontal: 5),
                height: width * .08,
                width: width * .08,
                decoration: BoxDecoration(
                  color: CustomColors.buttonGray,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: CustomColors.containerBorder,
                    width: 1,
                  ),

                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1), // Shadow color
                  //     spreadRadius: 1, // Spread radius
                  //     blurRadius: 5, // Blur radius
                  //     offset: Offset(0, 5), // Shadow position (x, y)
                  //   ),
                  // ],
                ),
                child: Center(
                  child: Text(
                    "+",
                    style: symbolStyle,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class CustomVerticalPlusMinusTextBox extends StatelessWidget {
  final double width;
  final Function minusFunction;
  final Function plusFunction;
  final Function onChangeFunction;
  final TextEditingController textController;

  const CustomVerticalPlusMinusTextBox(
      {super.key,
      required this.width,
      required this.minusFunction,
      required this.plusFunction,
      required this.onChangeFunction,
      required this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              textController.text =
                  (int.parse(textController.text) - 1).toString();
              minusFunction();
            },
            child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: width * .1,
                width: width * .1,
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: CustomColors.containerBorder,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      spreadRadius: 1, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 5), // Shadow position (x, y)
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "-",
                    style: symbolStyle,
                  ),
                )),
          ),
          SizedBox(
            width: width * .1,
            height: width * .07,
            child: TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: grayTextStyle2,
              onChanged: (value) {
                if (textController.text == "") textController.text = "0";
                onChangeFunction();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              textController.text =
                  (int.parse(textController.text) + 1).toString();
              plusFunction();
            },
            child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: width * .1,
                width: width * .1,
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: CustomColors.containerBorder,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      spreadRadius: 1, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 5), // Shadow position (x, y)
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "+",
                    style: symbolStyle,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
