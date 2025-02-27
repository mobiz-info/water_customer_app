import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:water_customer_app/utils/colors.dart';
import 'package:water_customer_app/widgets/custom_appbar.dart';
import 'package:water_customer_app/widgets/custom_button.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  _TermsAndConditionsScreenState createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
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
      ..loadRequest(Uri.parse('${baseUrl}/api/terms_and_conditions/'));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar('Terms & Conditions'),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0), // Padding around the buttons
            child: SizedBox(
              height: screenHeight * .06, // Height of the button container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      buttonText: 'Decline',
                      tapFunction: () {
                        Get.back();
                      },
                      colorGradient: CustomColors.lightGrayGradient(),
                    ),
                  ),
                  SizedBox(width: 20.0), // Spacer between buttons
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      buttonText: 'Accept',
                      tapFunction: () {
                        Get.back();
                      },
                      colorGradient: CustomColors.lightBlueGradient(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
