import 'package:flutter/material.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar('Notifications'),
    );
  }
}
