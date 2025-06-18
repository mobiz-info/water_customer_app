import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_customer_app/screens/dashboard/product/place_order/order_place_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_plus_minus_text_box.dart';

class OrderItemsScreen extends StatefulWidget {
  final String itemName;
  final String itemId;
  final double itemRate;

  OrderItemsScreen({
    required this.itemName,
    required this.itemId,
    required this.itemRate,
    super.key,
  });

  @override
  State<OrderItemsScreen> createState() => _OrderItemsScreenState();
}

class _OrderItemsScreenState extends State<OrderItemsScreen> {
  TextEditingController countController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  //DateTime selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    countController.text = '0';
    super.initState();
    print("date1234567");
    print(selectedDate);
    selectDate(context);
    setState(() {

    });
  }

  @override
  void dispose() {
    countController.dispose();
    super.dispose();
  }

  Future<void> selectDate(BuildContext context) async {

    print("date123");
    print(selectedDate);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    OrderPlaceController orderPlaceController = OrderPlaceController();

    // Date for API request in yyyy-mm-dd format
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar('Place your order now'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Image.asset(
                          'Assets/Images/Home/outstanding/coupon.png'),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.itemName,
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
                              'AED  ${widget.itemRate} ',
                              style: grayTextStyle2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Qty ',
                              style: grayTextStyle2,
                            ),
                            CustomPlusMinusTextBox(
                              width: screenWidth,
                              minusFunction: () {
                                orderPlaceController.updateTotalAmount(
                                    countController.text, widget.itemRate);
                              },
                              plusFunction: () {
                                orderPlaceController.updateTotalAmount(
                                    countController.text, widget.itemRate);
                              },
                              onChangeFunction: () {
                                orderPlaceController.updateTotalAmount(
                                    countController.text, widget.itemRate);
                              },
                              textController: countController,
                            ),
                          ],
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
                            Obx(
                                  () => Text(
                                'AED   ${orderPlaceController.totalAmount} ',
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
              SizedBox(
                height: screenHeight * .02,
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
                    onTap: () => selectDate(context),
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
                                DateFormat('dd-MM-yyyy')
                                    .format(selectedDate), // Display date in dd-mm-yyyy format
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
                buttonText: 'Place Your Order',
                tapFunction: () {
                  orderPlaceController.orderWater(
                    formattedDate, // Send the date in yyyy-mm-dd format for API request
                    widget.itemId,
                    int.parse(countController.text),
                  );
                },
                colorGradient: CustomColors.lightBlueGradient(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
