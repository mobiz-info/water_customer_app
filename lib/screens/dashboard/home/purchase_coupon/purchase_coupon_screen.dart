import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_customer_app/screens/dashboard/cart/cart_screen.dart';
import 'package:water_customer_app/screens/dashboard/home/purchase_coupon/place_order_coupon/order_place_screen.dart';
import 'package:water_customer_app/screens/dashboard/home/purchase_coupon/purchase_coupon_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';
import 'package:water_customer_app/widgets/custom_plus_minus_text_box.dart';
// import 'package:water_customer_app/utils/globals.dart' as globals;

class PurchaseCouponScreen extends StatefulWidget {
  const PurchaseCouponScreen({super.key});

  @override
  State<PurchaseCouponScreen> createState() => _PurchaseCouponScreenState();
}

class _PurchaseCouponScreenState extends State<PurchaseCouponScreen> {
  TextEditingController Controller = TextEditingController();
  PurchaseCouponController purchaseCouponController=PurchaseCouponController();

  DateTime selectedDate = DateTime.now();

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
      formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }
@override
  void initState() {
    purchaseCouponController.getCouponList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar('Coupon Purchase'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
              () => Column(
            children: [
              purchaseCouponController.isLoadingProductList==false ?
                  Expanded(    flex: 1,
                      child: purchaseCouponController.couponListResponseModel?.data?.isNotEmpty==true?
                      ListView.separated(
                        itemCount:  purchaseCouponController.couponListResponseModel!.data!
                            .length,
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 10, // Adjust space between items as needed
                            ),
                        itemBuilder: (context, index) {

                          return couponTile(index,
                            purchaseCouponController.couponListResponseModel!.data![index].id ?? '',
                            purchaseCouponController.couponListResponseModel!.data![index].productName ?? '',
                            purchaseCouponController.couponListResponseModel!.data![index].leafCount ?? 0,
                            purchaseCouponController.couponListResponseModel!.data![index].rate ?? 0.0,
                          );
                        },
                      ): SizedBox()
                  ) : Center(child: CircularProgressIndicator()),


            ],
          ),
        ),
      ),
    );
  }

  Widget couponTile(int index, String couponId,String couponName, int leafNo, double price,
     ) {
    var coupon = purchaseCouponController.couponListResponseModel!.data![index];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
RxBool isInCart = purchaseCouponController.isProductInCart(couponId).obs;
    return GestureDetector(
      onTap: (){
        // Get.to(OrderItemsScreen(
        //   itemId: couponId,
        //   itemName:couponName ,
        //   itemRate: price,
        //
        // ));
      },
      child: Container(
        height: screenHeight * .2,
        width: screenWidth,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: CustomColors.containerBorder, // Set your desired color
            width: 1.0, // Set the width of the bottom border
          ),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenHeight * .15,
              width: screenHeight * .15,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: index % 2 == 0
                      ? CustomColors.lightBlueGradient()
                      : CustomColors.lightGrayGradient()),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        leafNo.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: index % 2 == 0
                              ? CustomColors.white
                              : CustomColors.cardTextColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color:
                        index % 2 == 0 ? CustomColors.white : CustomColors.text,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Coupons",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: index % 2 == 0
                            ? CustomColors.white
                            : CustomColors.cardTextColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * .45,
              child: Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      couponName,
                      textAlign: TextAlign.center,
                      style: grayTextStyle2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Price   :',
                          style: grayTextStyle2,
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' AED ',
                              style: grayTextStyle2,
                            ),
                            Text(
                              price.toString(),
                              style: grayTextStyle2,
                            ),
                          ],
                        ),



                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                              () => GestureDetector(
                            onTap: () async {
                              if (isInCart.value) {
                                 //purchaseCouponController.deleteTheCart();

                              } else {

                                await purchaseCouponController.addToCart(
                                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                  couponId,
                                  1,
                                  price,
                                );
                                isInCart.value = purchaseCouponController.isProductInCart(couponId);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:isInCart.value
                                ? Border.all(width: 1,)
                                :null,
                                color:isInCart.value
                                    ? Colors.transparent
                                    : CustomColors.accentColor,
                              ),
                              padding: EdgeInsets.all(screenHeight * .008),
                              margin: EdgeInsets.all(screenHeight * .005),
                              child: Text(
                                isInCart.value
                                    ? 'Already in Cart'
                                    : 'Add to Cart',
                                style: isInCart.value
                                ?grayTextStyle2
                                :whiteTextStyle2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox()
            // CustomVerticalPlusMinusTextBox(
            //   width: screenWidth,
            //   minusFunction: () {},
            //   plusFunction: () {},
            //   onChangeFunction: () {},
            //   textController: controller,
            // )
          ],
        ),
      ),
    );
  }
}
