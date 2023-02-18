import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key, required this.paymentUrl}) : super(key: key);
  String paymentUrl;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final _key = UniqueKey();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(height40 * 1.5),
      //   child: Container(width: screenWidth, color: silver),
      // ),
      body: SafeArea(
        child: Column(children: [
          header(),
          Expanded(
            child: Stack(
              children: [
                WebView(
                  initialUrl: widget.paymentUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  // onProgress: (int progress) {
                  //   print('Please wait\nLoading (progress : $progress%)');
                  // },
                  // navigationDelegate: (NavigationRequest request) {
                  //   if (request.url.startsWith('https://www.youtube.com/')) {
                  //     print('blocking navigation to $request}');
                  //     return NavigationDecision.prevent;
                  //   }
                  //   print('allowing navigation to $request');
                  //   return NavigationDecision.navigate;
                  // },
                  // onPageStarted: (String url) {
                  //   print('Page started loading: $url');
                  // },
                  // onPageFinished: (String url) {
                  //   print('Page finished loading: $url');
                  // },
                  gestureNavigationEnabled: true,
                  // backgroundColor: const Color(0x00000000),
                ),
                isLoading
                    ? Container(
                        width: double.maxFinite,
                        color: backgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/processing.png',
                              width: font24 * 6,
                            ),
                            SizedBox(
                              height: height4,
                            ),
                            Text(
                              'Please wait...',
                              style: vietnam400.copyWith(
                                fontSize: font16,
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Stack(),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget header() {
    return Container(
      color: white,
      height: height40 * 1.5,
      padding: EdgeInsets.symmetric(horizontal: width12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
          Text(
            'Payment',
            style: publicsans600.copyWith(fontSize: font16, color: blackColor),
          ),
          Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
