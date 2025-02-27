import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/utils/styles.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatelessWidget {
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
            title: Text('About', style: whiteTextStyle2),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load app information'));
          } else {
            final packageInfo = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      packageInfo.appName,
                      style: grayTextStyle3
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Version: ${packageInfo.version} (Build ${packageInfo.buildNumber})',
                      style:grayTextStyle2
                    ),
                  ),
                  // SizedBox(height: 24),
                  // Text(
                  //   'App Details',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: CustomColors.cardTextColor,
                  //   ),
                  // ),
                  // SizedBox(height: 16),
                  // _buildDetailItem('Developed by', 'Your Company Name'),
                  // _buildDetailItem('Contact', 'support@yourcompany.com'),
                  // _buildDetailItem('Website', 'www.yourcompany.com'),
                  // // Add more details as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }


}
