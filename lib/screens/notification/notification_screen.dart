import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:water_customer_app/Models/notification_model.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
    child: Container(
    decoration: BoxDecoration(
    gradient: CustomColors.lightBlueGradient()
    ),
    child: AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: CustomColors.white, // Set your desired color here
          size: 20, // Set your desired size here
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    title: Text('Notifications',style: whiteTextStyle2,),
    backgroundColor: Colors.transparent, // Important to keep AppBar transparent
    elevation: 0, // Optional: Removes shadow
    ),
    ),
    ),
      body:
      Obx(() => globals.expenseAddList?.length==0?Center(child: Text("No notifications to display")):ListView.builder(
        itemCount: globals.expenseAddList?.length ?? 0,
        itemBuilder: (context, index) {
          // Access the current Data object from the list
          final Data expenseData = globals.expenseAddList![index];

          // Return the widget representing a single list item
          return NotificationItem(expenseData.title??"", expenseData.messaage??"", expenseData.time??"");
        },
      ))
      // ListView.builder(
      //   itemCount: notifications.length,
      //   itemBuilder: (context, index) {
      //     return NotificationItem(
      //       notifications[index].title,
      //        notifications[index].subtitle,
      //       notifications[index].date,
      //     );
      //   },
      // ),
    );
  }


Widget NotificationItem (
  final String title,
  final String subtitle,
  final String date)
{
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Icon(Icons.notifications),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          date,
          style: grayTextStyle1,
        ),
      ),
    );
  }

}

// Dummy notification data
class Notification {
  final String title;
  final String subtitle;
  final String date;

  Notification({required this.title, required this.subtitle, required this.date});
}

