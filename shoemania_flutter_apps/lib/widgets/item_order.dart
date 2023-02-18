import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoemania/pages/orders/detail_order_page.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class ItemOrder extends StatelessWidget {
  ItemOrder({
    Key? key,
    required this.orderId,
    required this.createdAt,
    required this.status,
    required this.imageUrl,
    required this.total,
  }) : super(key: key);

  int orderId;
  DateTime createdAt;
  String status;
  String imageUrl;
  int total;

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xFFFFFFFF);
    // if (status == "SUCCESS") {
    //   background == success;
    // } else if (status == "CANCELLED") {
    //   background = error;
    // } else {
    //   background = secon;
    // }
    switch (status) {
      case "SUCCESS":
        background = success;
        break;
      case "CANCELLED":
        background = error;
        break;
      default:
        background = Colors.indigoAccent;
        break;
    }
    return Container(
      width: screenWidth,
      margin: EdgeInsets.symmetric(vertical: height6, horizontal: width12),
      padding: EdgeInsets.symmetric(vertical: height12, horizontal: width16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width12), color: white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("d MMM yyyy").format(createdAt),
                style: vietnam400.copyWith(color: gray, fontSize: font11),
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: height4,
                    horizontal: width12,
                  ),
                  decoration: BoxDecoration(
                    color: background.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(width8 / 2),
                  ),
                  child: Text(
                    status == "SUCCESS"
                        ? "Complete"
                        : status == "CANCELED"
                            ? "Canceled"
                            : status == "PENDING"
                                ? "Waiting for Payment"
                                : status == "ON_DELIVERY"
                                    ? "On Delivery"
                                    : status == "ON_PROCESS"
                                        ? "On Process"
                                        : "",
                    style: vietnam400.copyWith(
                        color: background, fontSize: font11),
                  )),
            ],
          ),
          Divider(
            height: height16,
            color: silver,
            thickness: 1.2,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: width32 * 2,
                      height: width32 * 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width8),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: width12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Transaksi :',
                          style: vietnam400.copyWith(
                              fontSize: font10 + 0.5, color: gray),
                        ),
                        SizedBox(
                          height: height4,
                        ),
                        Text(
                          Helpers.convertToIdr(total),
                          style: vietnam500.copyWith(
                              fontSize: font13, color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailOrderPage(id: orderId)));
                  },
                  child: Text(
                    'See Detail',
                    style: vietnam400.copyWith(fontSize: font10 + 1),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: primaryColor,
                    side: BorderSide(color: primaryColor, width: 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width8), // <-- Radius
                    ),
                  ),
                ),
                // SizedBox(
                //   width: screenWidth / 1.8,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             'Total Transaksi :',
                //             style:
                //                 vietnam400.copyWith(fontSize: font12, color: gray),
                //           ),
                //           Text(
                //             'Rp 259.000',
                //             style: vietnam500.copyWith(
                //                 fontSize: font15, color: primaryColor),
                //           ),
                //         ],
                //       ),
                //       ElevatedButton(
                //         onPressed: () {},
                //         child: Text('See'),
                //         style: OutlinedButton.styleFrom(
                //           primary: primaryColor,
                //           side: BorderSide(color: primaryColor, width: 1.0),
                //           shape: RoundedRectangleBorder(
                //             borderRadius:
                //                 BorderRadius.circular(width8), // <-- Radius
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ]),
        ],
      ),
    );
  }
}
