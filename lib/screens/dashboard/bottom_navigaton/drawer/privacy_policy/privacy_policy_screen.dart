import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {

            return NavigationDecision.navigate;
          },
        ),
      )
      // ..loadRequest(Uri.parse('${baseUrl}/api/terms_and_conditions/'));
      ..loadRequest(Uri.parse('${baseUrl}/api/privacy-policy/'));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar('Privacy Policy'),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),

        ],
      ),
    );
  }
}
