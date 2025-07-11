import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/dashboard/home/transactions/purchase/purchase_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';

import '../../../../../Models/cooler_purchase_response_model.dart';

class PurchaseScreen extends StatefulWidget {
  final String appTittle;

  const PurchaseScreen({required this.appTittle, super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  PurchaseController purchaseController = PurchaseController();

  @override
  void initState() {
    super.initState();
    if (widget.appTittle == "Water Bottle Purchase") {
      print("Checkpoint 1.1");
      purchaseController.getWaterBottlePurchase();
    } else if (widget.appTittle == "Coupon Purchases") {
      print("Checkpoint 2.1");
      purchaseController.getCouponPurchase();
    } else if (widget.appTittle == "Dispenser & Cooler Purchase") {
      print("Checkpoint 3.1");
      purchaseController.getCoolerPurchase();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(widget.appTittle),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: widget.appTittle == "Dispenser & Cooler Purchase"
            ? Obx(
              () => purchaseController.isLoading != false
              ? Center(child: CircularProgressIndicator())
              : purchaseController.coolerPurchaseResponseModel?.orders?.isEmpty ?? true
              ? _noDataWidget("No cooler purchases found.")
              : ListView.separated(
            itemCount: purchaseController
                .coolerPurchaseResponseModel?.orders?.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) => navigationItem(
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].deliveryDate ?? '',
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].id ?? '',
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].orderStatus ?? '',
              screenWidth,
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].totalQuantity ?? 0,

            ),
          ),
        )
            : widget.appTittle == "Water Bottle Purchase"
            ? Obx(
              () => purchaseController.isLoading != false
              ? Center(child: CircularProgressIndicator())
              : purchaseController.coolerPurchaseResponseModel?.orders?.isEmpty ?? true
              ? _noDataWidget("No water bottle purchases found.")
              : ListView.separated(
            itemCount: purchaseController
                .coolerPurchaseResponseModel?.orders?.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) => navigationItem(
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].deliveryDate ?? '',
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].id ?? '',
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].orderStatus ?? '',
              screenWidth,
              purchaseController.coolerPurchaseResponseModel
                  ?.orders?[index].totalQuantity ?? 0,

            ),
          ),
        )
            : Obx(
              () => purchaseController.isLoading != false
              ? Center(child: CircularProgressIndicator())
              : purchaseController.couponPurchaseResponseModel?.couponList.isEmpty ?? true
              ? _noDataWidget("No coupon purchases found.")
              : ListView.separated(
            itemCount: purchaseController
                .couponPurchaseResponseModel?.couponList.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) => navigationItem(
              purchaseController.couponPurchaseResponseModel
                  ?.couponList[index].createdDate ?? '',
              purchaseController.couponPurchaseResponseModel
                  ?.couponList[index].id ?? '',
              purchaseController.couponPurchaseResponseModel
                  ?.couponList[index].orderStatus ?? '',
              screenWidth,
              purchaseController.couponPurchaseResponseModel
                  ?.couponList[index].totalQuantity ?? 0,


            ),
          ),
        ),
      ),
    );
  }
//created by abhijth
  Widget navigationItem(
      String orderDate, String orderNo, String orderStatus, double screenWidth , int? totalQuantity  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColors.containerBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: Text('Order No', style: grayTextStyle1)),
              Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(orderNo, style: grayTextStyle1, textAlign: TextAlign.start),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 3, child: Text('Purchase Date', style: grayTextStyle1)),
              Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
              Expanded(
                flex: 5,
                child: Text(orderDate, style: grayTextStyle1, textAlign: TextAlign.start),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 3, child: Text('Purchase Type', style: grayTextStyle1)),
              Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
              Expanded(flex: 5, child: Text(orderStatus, style: grayTextStyle1)),
            ],
          ),
          SizedBox(height: 5),
          // Add this new row for quantity display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 3, child: Text('No Of Bottle Purchased', style: grayTextStyle1)),
              Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
              Expanded(
                flex: 5,
                child: Text(
                    totalQuantity?.toString() ?? '0',
                    style: grayTextStyle1
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //created by new for new requirement for customer
  // Widget navigationItem(
  //     String orderDate, String orderNo, String orderStatus, double screenWidth, [
  //       List<OrderItem>? items, // optional
  //     ]) {
  //   // Get the first item's quantity (assuming there's at least one item)
  //   String quantity = items?.isNotEmpty == true ? items![0].quantity ?? '0' : '0';
  //
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: CustomColors.containerBorder),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Expanded(flex: 3, child: Text('Order no', style: grayTextStyle1)),
  //             Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
  //             Expanded(
  //               flex: 5,
  //               child: SingleChildScrollView(
  //                 scrollDirection: Axis.horizontal,
  //                 child: Text(orderNo, style: grayTextStyle1, textAlign: TextAlign.start),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 5),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(flex: 3, child: Text('Order date', style: grayTextStyle1)),
  //             Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
  //             Expanded(
  //               flex: 5,
  //               child: Text(orderDate, style: grayTextStyle1, textAlign: TextAlign.start),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 5),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(flex: 3, child: Text('Order status', style: grayTextStyle1)),
  //             Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
  //             Expanded(flex: 5, child: Text(orderStatus, style: grayTextStyle1)),
  //           ],
  //         ),
  //         //SizedBox(height: 5),
  //         // Row(
  //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         //   children: [
  //         //     Expanded(flex: 3, child: Text('No of Bottle', style: grayTextStyle1)),
  //         //     Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
  //         //     Expanded(flex: 5, child: Text(quantity, style: grayTextStyle1)),
  //         //   ],
  //         // ),
  //         // Only show "No of Bottle" if items is not null
  //         if (items != null) ...[
  //           SizedBox(height: 5),
  //           Row(
  //             children: [
  //               Expanded(flex: 3, child: Text('No of Bottle', style: grayTextStyle1)),
  //               Expanded(flex: 1, child: Text(':', style: grayTextStyle1)),
  //               Expanded(flex: 5, child: Text(quantity, style: grayTextStyle1)),
  //             ],
  //           ),
  //         ],
  //       ],
  //     ),
  //   );
  // }
  Widget _noDataWidget(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 16, color: CustomColors.text),
        textAlign: TextAlign.center,
      ),
    );
  }
}
