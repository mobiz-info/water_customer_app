import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_customer_app/Models/product_List_response_model.dart';
import 'package:water_customer_app/screens/dashboard/bottom_navigaton/bottom_navigationbar_controller.dart';
import 'package:water_customer_app/screens/dashboard/product/product_list_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/functions.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';

import 'place_order/order_place_screen.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListController productListController = ProductListController();
  final BottomNavigationBarController controller =
  Get.put(BottomNavigationBarController());
  @override
  void initState() {
    productListController.getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          controller.changeTabIndex(0);

          //exit(0);
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: Obx(
              () =>
              Column(
                children: [
                  productListController.isLoadingProductList == false
                      ? Expanded(
                    flex: 1,
                    child: productListController.productListResponseModel?.data
                        ?.isNotEmpty == true
                        ? ListView.separated(
                      itemCount: productListController.productListResponseModel!
                          .data!
                          .where((product) =>
                      product.productName?.toLowerCase() != '5 gallon')
                          .length,
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            height: 10, // Adjust space between items as needed
                          ),
                      itemBuilder: (context, index) {
                        // Filter out "5 gallon" products
                        final filteredProducts = productListController
                            .productListResponseModel!.data!
                            .where((product) =>
                        product.productName?.toLowerCase() != '5 gallon')
                            .toList();

                        // Now pass the product directly to the otherItem function
                        return otherItem(
                          filteredProducts[index], // Pass the filtered product
                          screenWidth,
                          screenHeight,
                        );
                      },
                    )
                        : SizedBox(),
                  )
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
        ),
      ),
    );
  }

  Widget otherItem(Product product, double screenWidth, double screenHeight) {
    RxBool isInCart = productListController.isProductInCart(product.id??'').obs;

    return GestureDetector(
      onTap: () {
        // Get.to(OrderItemsScreen(
        //   itemId: product.id ?? '',
        //   itemName: product.productName ?? '',
        //   itemRate: product.rate ?? 0.0,
        // ));
      },
      child: Container(
        margin: EdgeInsets.only(top: screenWidth * 0.04, right: 20, left: 20),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: CustomColors.containerBorder),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                  decoration: BoxDecoration(
                    color: CustomColors.transparentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(getImageUrl(product.productName ?? ''),
                      height: screenWidth * 0.2, width: screenWidth * 0.2),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(product.productName ?? '', style: grayTextStyle2),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'AED',
                            style: grayTextStyle2,
                          ),
                          TextSpan(
                            text: '  ',
                            style: grayHeadStyle1,
                          ),
                          TextSpan(
                            text: product.rate?.toString() ?? '',
                            style: grayHeadStyle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                      () =>
          productListController.isLoadingCart.value == true &&
          productListController.selectedProductId.value == product.id
      ? Center(child: CircularProgressIndicator()) // Show loader only on the clicked button
        :GestureDetector(
                        onTap: () async {
                          if (isInCart.value) {
                            // Implement remove from cart functionality
                          } else {
                            await productListController.addToCart(
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              product.id ?? '',
                              1,
                              product.rate ?? 0.0,
                            );
                            isInCart.value = productListController.isProductInCart(product.id??'');
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:isInCart.value
                                ? Border.all(width: 1,)
                                :null,
                            color: isInCart.value
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
                      )
                 ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


