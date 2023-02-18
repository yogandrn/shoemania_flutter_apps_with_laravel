import 'package:flutter/material.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';

class OrderFailedPage extends StatelessWidget {
  const OrderFailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          header(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/opps.png',
                  width: font24 * 6,
                ),
                SizedBox(
                  height: height12,
                ),
                Text(
                  'Transaction Failed',
                  style: vietnam500.copyWith(
                    fontSize: font14,
                    color: blackColor,
                  ),
                ),
                SizedBox(
                  height: height8,
                ),
                Text(
                  'There is something wrong\non your transaction!',
                  textAlign: TextAlign.center,
                  style: vietnam400.copyWith(
                    fontSize: font13,
                    color: gray,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget header(BuildContext context) {
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
