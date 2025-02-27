import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/screens/dashboard/home/custody_items/custody_item_controller.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/functions.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';

class CustodyItemScreen extends StatefulWidget {
  const CustodyItemScreen({super.key});

  @override
  State<CustodyItemScreen> createState() => _CustodyItemScreenState();
}

class _CustodyItemScreenState extends State<CustodyItemScreen> {
  CustodyItemController custodyItemController =Get.put(CustodyItemController());
 @override
  void initState() {
   custodyItemController.getMyCustody();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: CustomAppBar('Items with me'),
      body: Obx(
            () => Column(
          children: [
            // outStandingItem("Assets/Images/Home/outstanding/water_can_n.png", "5 Gallon ",'Qty',"0", screenWidth)
            // ,outStandingItem("Assets/Images/Watercan.png", "Water ", 'Qty','0',screenWidth)
            // , outStandingItem("Assets/Images/Home/custody/dispenser.png", "Pot Dispenser",'Qty','0', screenWidth)
          custodyItemController.isLoading.value==false ?
              Expanded(
                  flex:1,
                  child: custodyItemController.myCustodyResponseModel?.custody?.isNotEmpty==true
                      ?
                  ListView.separated(
                    itemCount:  custodyItemController.myCustodyResponseModel!.custody!
                       .length,
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          height: 10, // Adjust space between items as needed
                        ),
                    itemBuilder: (context, index) {
                      // Filter out "5 gallon" products


                      return outStandingItem(
                        custodyItemController.myCustodyResponseModel?.custody?[index].productName ?? '',
                        custodyItemController.myCustodyResponseModel?.custody?[index].quantity.toString() ?? '',
                        screenWidth,
                      );
                    },
                  ): SizedBox(
                    height: screenHeight * .6,
                    child: Center(child: Text('no item in custody...', style: grayTextStyle2)),
                  ),
              ):
          Center(child: CircularProgressIndicator()),


          ],
        ),
      ),

    );
  }
  Widget outStandingItem(String text,String count, double screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: screenWidth * 0.04,right: 20,left: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: CustomColors.containerBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors.transparentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(getImageUrl(text),height: screenWidth * 0.2,width: screenWidth * 0.2,)),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: grayTextStyle2),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:'Qty',
                      style: grayTextStyle2,
                    ),TextSpan(
                      text: '  ',
                      style: grayHeadStyle1,
                    ),
                    TextSpan(
                      text: count,
                      style: grayHeadStyle1,
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
