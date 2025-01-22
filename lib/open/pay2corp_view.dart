import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';

class Pay2corpView extends StatelessWidget {
  final String walletRequestMessage;

  const Pay2corpView({
    super.key,
    required this.walletRequestMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VardhmanColors.dividerGrey,
      body: SafeArea(
        child: InAppWebView(
          key: GlobalKey(),
          initialSettings: InAppWebViewSettings(
            useShouldOverrideUrlLoading: true,
            useShouldInterceptRequest: true,
            useShouldInterceptAjaxRequest: true,
            useShouldInterceptFetchRequest: true,
            isInspectable: true,
          ),
          // initialUrlRequest: URLRequest(
          //   url: WebUri('https://demo.b2biz.co.in/ws/payment'),
          // ),
          initialData: InAppWebViewInitialData(
            data: '''<!DOCTYPE html>
                  <html lang="en">
                  <head></head>
                  <body>
                      <form method="post" id="form" action="https://demo.b2biz.co.in/ws/payment">
                          <input type="text" id="walletClientCode" name="walletClientCode" value="WT-1474">
                          <input type="text" id="walletRequestMessage" name="walletRequestMessage" value="$walletRequestMessage">
                          <button type="submit">Send Data</button>
                      </form>
                  </body>
                  </html>''',
          ),
          onLoadStart: (controller, url) {
            log('onLoadStart $url');
          },
          onLoadStop: (controller, url) {
            log('onLoadStop url $url');

            if (url.toString().contains('about:blank')) {
              // controller.evaluateJavascript(
              //     source: 'document.getElementById("form").submit();');
            } else if (url.toString().contains('returnPGPayment')) {
              Get.back(
                result: true,
              );
            } else if (url.toString().contains('vardhmanthreads.com')) {
              Get.back(
                result: false,
              );
            }
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final url = navigationAction.request.url;

            log('shouldOverrideUrlLoading $url');

            if (url.toString().contains('cancelWSRequest')) {
              Get.back(
                result: false,
              );
            }

            return NavigationActionPolicy.ALLOW;
          },
        ),
      ),
    );
  }
}
