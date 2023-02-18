import 'package:flutter/material.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/widgets/item_order.dart';
import 'package:shoemania/widgets/item_product_grid.dart';
import 'package:shoemania/widgets/item_product_vertical.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Column(
          children: [header(), listOrders()],
        )));
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
            'My Order',
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

  // PreferredSizeWidget header() {
  //   return PreferredSize(
  //     preferredSize: Size.fromHeight(height36 * 2),
  //     child: AppBar(
  //       backgroundColor: white,
  //       automaticallyImplyLeading: true,
  //       foregroundColor: primaryColor,
  //       elevation: 0,
  //       centerTitle: true,
  //       title: Text(
  //         'My Order',
  //         style: publicsans600.copyWith(fontSize: font18, color: blackColor),
  //       ),
  //     ),
  //   );
  // }

  Widget listOrders() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: height8),
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ItemOrder(
              orderId: 1,
              createdAt: DateTime.now(),
              status: "SUCCESS",
              total: 259000,
              imageUrl:
                  'http://sipaling-ngoding.my.id/shoemania/laravel/storage/app/public/assets/products/2022//HJmKJ5T00lKQx6I33DiaHKfPI8qCq7wHN0ZqDFxS.jpg',
            );
          }),
    );
  }
}
