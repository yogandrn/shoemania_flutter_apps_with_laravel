import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/transaction_model.dart';
import 'package:shoemania/pages/orders/payment_page.dart';
import 'package:shoemania/providers/order_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';
import 'package:shoemania/widgets/modal_confirm_order.dart';

class DetailOrderPage extends StatefulWidget {
  DetailOrderPage({Key? key, required this.id}) : super(key: key);

  int id;

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  bool isLoading = true;
  Transaction? order;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    order = Provider.of<OrderProvider>(context, listen: false)
        .orders
        .firstWhere((element) => element.id == widget.id);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<OrderProvider>(context, listen: false)
        .getOrder(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Column(
          children: [
            header(),
            Expanded(
              child: isLoading
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: primaryColor, size: width12 * 5),
                    )
                  : RefreshIndicator(
                      onRefresh: refreshData,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: height12,
                          ),
                          status(),
                          SizedBox(
                            height: height12,
                          ),
                          deliveryAddress(),
                          SizedBox(
                            height: height12,
                          ),
                          listItem(),
                          SizedBox(
                            height: height12,
                          ),
                          delivery(),
                          SizedBox(
                            height: height12,
                          ),
                          summary(),
                          SizedBox(
                            height: height12,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        )),
        bottomNavigationBar: isLoading
            ? Container(width: 0, height: 0)
            : order!.status! == "ON_DELIVERY"
                ? GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(width16))),
                          context: context,
                          builder: (context) {
                            return ModalConfirmOrder(id: widget.id);
                            // }
                          });
                    },
                    child: Container(
                      width: screenWidth,
                      height: height40 * 1.8,
                      color: white,
                      padding: EdgeInsets.symmetric(
                          horizontal: width20, vertical: height12 - 2),
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(width12)),
                        padding: EdgeInsets.symmetric(
                          vertical: height8,
                        ),
                        child: Center(
                          child: Text(
                            'Confirm Order',
                            style: vietnam500.copyWith(
                                fontSize: font14, color: white),
                          ),
                        ),
                      ),
                    ),
                  )
                : order!.status! == "PENDING"
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentPage(
                                      paymentUrl: order!.paymentUrl!)));
                        },
                        child: Container(
                          width: screenWidth,
                          height: height40 * 1.8,
                          color: white,
                          padding: EdgeInsets.symmetric(
                              horizontal: width20, vertical: height12 - 2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(width12)),
                            padding: EdgeInsets.symmetric(
                              vertical: height8,
                            ),
                            child: Center(
                              child: Text(
                                'Pay Now',
                                style: vietnam500.copyWith(
                                    fontSize: font14, color: white),
                              ),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: screenWidth,
                          height: height40 * 1.8,
                          color: white,
                          padding: EdgeInsets.symmetric(
                              horizontal: width20, vertical: height12 - 2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(width12)),
                            padding: EdgeInsets.symmetric(
                              vertical: height8,
                            ),
                            child: Center(
                              child: Text(
                                'Back',
                                style: vietnam500.copyWith(
                                    fontSize: font14, color: white),
                              ),
                            ),
                          ),
                        ),
                      ));
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
            'Order Detail',
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

  Widget status() {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font13, color: blackColor),
              ),
              Text(
                order!.status! == "SUCCESS"
                    ? "Complete"
                    : order!.status! == "CANCELED"
                        ? "Canceled"
                        : order!.status! == "PENDING"
                            ? "Waiting for Payment"
                            : order!.status! == "ON_DELIVERY"
                                ? "On Delivery"
                                : order!.status! == "ON_PROCESS"
                                    ? "On Process"
                                    : "",
                style: vietnam500.copyWith(
                    height: 1.5, fontSize: font13, color: primaryColor),
              ),
            ],
          ),
          Divider(height: height16, thickness: 1.0, color: silver),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order ID",
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
              Text(
                order!.orderId!,
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time",
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
              Text(
                DateFormat("d-MMM-yyyy, H:m:s").format(order!.createdAt!),
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Admin Fee",
          //       style: vietnam400.copyWith(
          //           height: 1.5, fontSize: font12, color: blackColor),
          //     ),
          //     Text(
          //       Helpers.convertToIdr(2500),
          //       style: vietnam400.copyWith(
          //           height: 1.5, fontSize: font12, color: blackColor),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget deliveryAddress() {
    // final addresses = Provider.of<AuthProvider>(context, listen: false).addresses;
    // final address = addresses.firstWhere((element) => element.id == widget.addressId);
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(vertical: height16, horizontal: width24),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivered to",
            style: vietnam500.copyWith(fontSize: font13, color: primaryColor),
          ),
          SizedBox(
            height: height6,
          ),
          Text(order!.address!.name! + " | " + order!.address!.phoneNumber!,
              softWrap: true,
              style: vietnam500.copyWith(fontSize: font12, color: blackColor)),
          Text(
            order!.address!.address!,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: vietnam400.copyWith(
                height: 1.5, fontSize: font12, color: darkgrey),
          ),
          Text(
            "Kode Pos " + order!.address!.postalCode!,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: vietnam400.copyWith(
                height: 1.5, fontSize: font12, color: darkgrey),
          ),
        ],
      ),
    );
  }

  Widget listItem() {
    return Container(
      width: screenWidth,
      color: white,
      padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Item",
            style: vietnam500.copyWith(fontSize: font13, color: primaryColor),
          ),
          SizedBox(
            height: height6,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order!.items!.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: height4,
                  thickness: 0.8,
                  color: silver,
                );
              },
              itemBuilder: (context, index) {
                return itemOrder(
                  order!.items![index].product!.name!,
                  order!.items![index].product!.price!,
                  order!.items![index].quantity!,
                  order!.items![index].product!.galleries![0].imageUrl!,
                );
                // );
              }),
          SizedBox(
            height: height8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal Order",
                style: vietnam400.copyWith(fontSize: font12, color: blackColor),
              ),
              Text(
                Helpers.convertToIdr(order!.subtotal!),
                style:
                    vietnam400.copyWith(fontSize: font12, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemOrder(String name, int price, int qty, String imgURL) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        vertical: height8,
        horizontal: width12,
      ),
      child: Row(children: [
        Container(
          width: width32 * 2,
          height: width32 * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width8),
            color: silver,
            image: DecorationImage(
              image: CachedNetworkImageProvider(imgURL),
            ),
          ),
        ),
        SizedBox(width: width12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              name,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: vietnam400.copyWith(fontSize: font12, color: blackColor),
            ),
            SizedBox(
              height: height6,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    Helpers.convertToIdr(price),
                    style: vietnam400.copyWith(
                        fontSize: font12, color: secondaryColor),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    qty.toString() + "x ",
                    textAlign: TextAlign.end,
                    style: vietnam400.copyWith(
                        fontSize: font12, color: blackColor),
                  ),
                ),
              ],
            ),
          ]),
        )
      ]),
    );
  }

  Widget summary() {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Shipment",
          //   style: vietnam500.copyWith(fontSize: font13, color: primaryColor),
          // ),
          // SizedBox(
          //   height: height8,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal Order",
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
              Text(
                Helpers.convertToIdr(order!.subtotal),
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shiping Price",
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
              Text(
                Helpers.convertToIdr(order!.shipping),
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admin Fee",
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
              Text(
                Helpers.convertToIdr(2500),
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font12, color: blackColor),
              ),
            ],
          ),
          Divider(height: height16, thickness: 1.0, color: silver),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Order",
                style: vietnam400.copyWith(
                    height: 1.5, fontSize: font13, color: blackColor),
              ),
              Text(
                Helpers.convertToIdr(order!.total),
                style: vietnam500.copyWith(
                    height: 1.5, fontSize: font13, color: primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget delivery() {
    return Container(
        width: screenWidth,
        color: white,
        padding: EdgeInsets.symmetric(vertical: height16, horizontal: width24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipment",
              style: vietnam500.copyWith(fontSize: font13, color: primaryColor),
            ),
            SizedBox(
              height: height6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Courier",
                  style: vietnam400.copyWith(
                      height: 1.5, fontSize: font12, color: blackColor),
                ),
                Text(
                  "JNE REG",
                  style: vietnam400.copyWith(
                      height: 1.5, fontSize: font12, color: blackColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Receipt Number",
                  style: vietnam400.copyWith(
                      height: 1.5, fontSize: font12, color: blackColor),
                ),
                Text(
                  order!.receipt!,
                  style: vietnam400.copyWith(
                      height: 1.5, fontSize: font12, color: blackColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Price",
                  style: vietnam400.copyWith(
                      height: 1.5, fontSize: font12, color: blackColor),
                ),
                Text(
                  Helpers.convertToIdr(order!.shipping),
                  style: vietnam400.copyWith(
                      height: 1.5, fontSize: font12, color: primaryColor),
                ),
              ],
            ),
          ],
        ));
  }
}
