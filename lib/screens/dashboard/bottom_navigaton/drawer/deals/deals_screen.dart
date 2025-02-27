import 'package:flutter/material.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar('Your deals'),

    );
  }
}
