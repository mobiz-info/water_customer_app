import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_customer_app/Models/parser_helper/parser_helper.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigationbar_controller.dart';
import 'package:water_customer_app/screens/dashboard/cart/cart_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/functions.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_plus_minus_text_box.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.put(CartController());

  final BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());
  DateTime selectedDate = DateTime.now(); // Initialize with the current date
  String formattedDate = '';
  //created by new
  bool isDatePicked  = false;
  @override
  void initState() {
    //created by new
   // _initializeDate();

    selectedDate = DateTime.now();
    formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    // Debug prints
    print('Initial selectedDate: $selectedDate');
    print('Initial formattedDate: $formattedDate');
    print('globals.nextDeliveryDate: ${globals.nextDeliveryDate}');

    //end.............

    //craeted by abhijith didnot use now because the date issue
    // if (globals.nextDeliveryDate == '' || globals.nextDeliveryDate == null) {
    //   formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    // } else {
    //   selectedDate = DateFormat('dd-MM-yyyy').parse(globals.nextDeliveryDate!);
    //   formattedDate = globals.nextDeliveryDate!;
    // }
    cartController.listTheCart();
    super.initState();
  }


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
        formattedDate = DateFormat('dd-MM-yyyy')
            .format(selectedDate); // Update formatted date
        //created by new
        isDatePicked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          controller.changeTabIndex(0);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.025,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Place Your Order Now', style: grayTextStyle3),
                  ],
                ),
                Obx(
                  () => cartController.isLoadingProductList != true
                      ? cartController.cartList.length != 0
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cartController.cartList.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height:
                                    10, // Adjust space between items as needed
                              ),
                              itemBuilder: (context, index) {
                                return cartTile(
                                  cartController.cartList[index].product ??
                                      '(----)',
                                  cartController.cartList[index].id ?? '',
                                  cartController.cartList[index].price ?? '',
                                  cartController.cartList[index].quantity ?? '',
                                  screenWidth,
                                  screenHeight,
                                );
                              },
                            )
                          : SizedBox()
                      : SizedBox(
                          height: screenHeight * .5, // Adjust height as needed
                          child: Center(child: CircularProgressIndicator()),
                        ),
                ),
                Obx(() => cartPlaceOrderTile(
                    context,
                    cartController.grandTotal.value,
                    screenWidth,
                    screenHeight)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartPlaceOrderTile(BuildContext context, String grandTotal,
      double screenWidth, double screenHeight) {
    return Container(
      height: isLandscape(context) ? screenWidth * 0.08 : null,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      child: Obx(
        () => cartController.cartList.length != 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Grand Total :     AED   ', style: grayTextStyle2),
                      Text(grandTotal, style: grayHeadStyle3),
                    ],
                  ),
                  SizedBox(height: screenHeight * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Required Date : ', style: grayTextStyle2),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: CustomColors.datePickerBg,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today,
                                    color: CustomColors.text),



                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child:Text(  //created by new
                                    isDatePicked
                                        ? formattedDate // user-picked
                                        : cartController.deliveryDate.value.toString(), // default
                                    style: TextStyle(color: CustomColors.text),
                                  ),
                                  //cretae dby abhijith
                                  // Text(
                                  //
                                  //   formattedDate!=selectedDate ? cartController.deliveryDate.value.toString():formattedDate, // Display the selected or default date
                                  //   style: TextStyle(color: CustomColors.text),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * .01),
                  cartController.isLoadingOrderPlace.value != true
                      ? CustomButton(
                          buttonText: 'Place Your Order',
                          tapFunction: () {
                            cartController.placeOrder();
                            Get.back();
                          },
                          colorGradient: CustomColors.lightBlueGradient(),
                        )
                      : Center(child: CircularProgressIndicator()),
                ],
              )
            : SizedBox(
                height: screenHeight * .6,
                child:
                    Center(child: Text('Cart is empty', style: grayTextStyle2)),
              ),
      ),
    );
  }

  Widget cartTile(String itemName, String productId, String amount,
      String count, double screenWidth, double screenHeight) {
    TextEditingController countController = TextEditingController();
    countController.text = count;
    return Container(
      height: isLandscape(context) ? screenWidth * 0.08 : null,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColors.containerBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Image.asset(
                      getImageUrl(itemName),
                      height: screenWidth * 0.2,
                      width: screenWidth * 0.2,
                    ),
                    CustomPlusMinusTextBox(
                      width: screenWidth,
                      minusFunction: () {
                        cartController.editOrder(
                            productId, parseInt(countController.text) ?? 1);
                      },
                      plusFunction: () {
                        cartController.editOrder(
                            productId, parseInt(countController.text) ?? 1);
                      },
                      onChangeFunction: () {
                        cartController.editOrder(
                            productId, parseInt(countController.text) ?? 1);
                      },
                      textController: countController,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(itemName, style: grayTextStyle2),
                    Text(amount, style: grayTextStyle2),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartController.deleteTheCart(productId);
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * .01),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total : ',
                      style: grayTextStyle2,
                    ),
                    //created by new
                    // TextSpan(
                    //   text: (double.parse(amount) *
                    //       (int.tryParse(countController.text) ?? 1)).toStringAsFixed(2),
                    //   style: grayTextStyle3,
                    // ),
                    //created by abhijith
                    TextSpan(
                      text: amount,
                      style: grayTextStyle3,
                    ),
                    TextSpan(
                      text: '  ',
                      style: grayTextStyle3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
