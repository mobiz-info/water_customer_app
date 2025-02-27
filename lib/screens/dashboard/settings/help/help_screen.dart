import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: CustomColors.lightBlueGradient(),
          ),
          child: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: CustomColors.white,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('Help', style: whiteTextStyle2),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            mailId!=""?_buildDetailItem('Contact', mailId):SizedBox(),
            phoneNo!=""?_buildDetailItem('Phone', phoneNo):SizedBox(),
            webSiteUrl!=""? _buildDetailItem('Website', webSiteUrl, isLink: true)
            :SizedBox(),
            // Add more details as needed
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String content, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: grayTextStyle2,
          ),
          isLink
              ? GestureDetector(
            onTap: () => _launchURL(content),
            child: Text(
              "${content}",
              style: grayTextStyle1.copyWith(color: Colors.blue),
            ),
          )
              : Text(
            content,
            style: grayTextStyle1,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url.startsWith('http') ? url : 'http://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
