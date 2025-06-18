import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_customer_app/screens/dashboard/home/order_water/order_water_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_plus_minus_text_box.dart';
import 'package:water_customer_app/widgets/custom_text_Field.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

import '../../../../utils/Common.dart';

class OrderWaterScreen extends StatefulWidget {
  const OrderWaterScreen({super.key});

  @override
  State<OrderWaterScreen> createState() => _OrderWaterScreenState();
}

class _OrderWaterScreenState extends State<OrderWaterScreen> {
  double emptyBottleAmount = 25.00;
  TextEditingController bottleCountController = TextEditingController();
  TextEditingController emptyBottleRequiredController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController noEmptyBottleReturnCountController =
      TextEditingController();
  DateTime selectedDate = DateTime.now();
  RxBool isInCart = false.obs;

  // Updated date format to dd-MM-yyyy
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      formattedDate =
          DateFormat('yyyy-MM-dd').format(selectedDate); // Updated date format
    }
  }

  OrderWaterController orderWaterController = OrderWaterController();

  void updateNetTotalAmount() {
    orderWaterController.totalNetAmount.value =
        ((emptyBottleAmount * (int.parse(emptyBottleRequiredController.text))) +
            (orderWaterController.totalAmount.value));
    totalAmountController.text =
        (orderWaterController.totalNetAmount.value).toString();
  }

  @override
  void initState() {
    isInCart.value = orderWaterController.isProductInCart(globals.waterId);
    print(AuthData().sales_type);
    print('00000');
    bottleCountController.text = '0';
    totalAmountController.text = '0';
    noEmptyBottleReturnCountController.text = '0';
    emptyBottleRequiredController.text = '0';

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controllers to free up resources
    bottleCountController.dispose();
    emptyBottleRequiredController.dispose();
    totalAmountController.dispose();
    noEmptyBottleReturnCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: CustomAppBar('Place your order now'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Image.asset("Assets/Images/Watercan.png")),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '5 Gallon Water Can ',
                          style: grayHeadStyle3,
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rate ',
                              style: grayTextStyle2,
                            ),
                            Text(
                              'AED  ${globals.waterRate} ',
                              style: grayTextStyle2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Qty ',
                                style: grayTextStyle2,
                              ),
                              SizedBox(
                                width: screenWidth * .3,
                                child: CustomPlusMinusTextBox(
                                  width: screenWidth,
                                  minusFunction: () {
                                    noEmptyBottleReturnCountController.text=bottleCountController.text;
                                    orderWaterController.updateTotalAmount(
                                        bottleCountController.text);
                                    updateNetTotalAmount();
                                  },
                                  plusFunction: () {
                                    noEmptyBottleReturnCountController.text=bottleCountController.text;
                                    orderWaterController.updateTotalAmount(
                                        bottleCountController.text);
                                    updateNetTotalAmount();
                                  },
                                  onChangeFunction: () {
                                    orderWaterController.updateTotalAmount(
                                        bottleCountController.text);
                                    updateNetTotalAmount();
                                  },
                                  textController: bottleCountController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        Divider(
                          color: CustomColors.containerBorder,
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount ',
                              style: grayTextStyle2,
                            ),
                            AuthData().sales_type == 'FOC'
                                ? Text(
                                    'AED   0.0 ',
                                    style: grayTextStyle2,
                                  )
                                : Obx(
                                    () => Text(
                                      'AED   ${orderWaterController.totalAmount} ',
                                      style: grayTextStyle2,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.containerBorder),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No of empty bottles to return ',
                          style: grayTextStyle1,
                        ),
                        SizedBox(
                            width: screenWidth * .20,
                            height: screenHeight * .03,
                            child: CustomTextField(
                              controller: noEmptyBottleReturnCountController,
                              border: true,
                              borderColor: CustomColors.containerBorder,
                              borderRadius: 5,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '  Select Delivery Date',
                    style: grayTextStyle1,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: CustomColors.datePickerBg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today,
                                color: CustomColors.text),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                DateFormat('dd-MM-yyyy').format(selectedDate),
                                style: TextStyle(color: CustomColors.text),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * .02,
              ),


              CustomButton(
                  buttonText:
                      isInCart.value ? 'Already in Cart' : 'Add to Cart',
                  tapFunction: () async {
                    if (isInCart.value) {
                      // Implement remove from cart functionality
                    } else {
                      await orderWaterController.addToCart(
                          formattedDate,
                          int.parse(bottleCountController.text),
                          ((emptyBottleAmount *
                                  (int.parse(
                                      emptyBottleRequiredController.text))) +
                              double.parse(totalAmountController.text)));
                      isInCart.value =
                          orderWaterController.isProductInCart(globals.waterId);
                    }
                  },
                  gradiant: true,
                  colorGradient: isInCart.value
                      ? CustomColors.lightGrayGradient()
                      : CustomColors.lightBlueGradient())
            ],
          ),
        ),
      ),
    );
  }
}
