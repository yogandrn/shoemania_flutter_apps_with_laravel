import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/address_model.dart';
import 'package:shoemania/models/cart_model.dart';
import 'package:shoemania/models/shipping_model.dart';
import 'package:shoemania/pages/orders/payment_page.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/providers/order_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key? key, required this.addressId}) : super(key: key);

  int addressId;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool isLoading = true;
  int subtotal = 0;
  int total = 0;
  int shipment = 0;
  int addressId = 0;
  Address? address;
  Shipping? shipping;
  List<Carts> carts = [];

  // Toast Error
  Widget errorToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Something went wrong on your order!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<CartProvider>(context, listen: false).getCarts();
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    subtotal = cartProvider.subtotal;
    shipment = cartProvider.shipping.cost;
    total = cartProvider.subtotal + shipment + 2500;
    address = authProvider.addresses
        .firstWhere((element) => element.id == widget.addressId);
    shipping = cartProvider.shipping;
    carts = cartProvider.carts;
    addressId = widget.addressId;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(children: [
            header(),
            Expanded(
                child: isLoading
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: primaryColor, size: width12 * 4),
                      )
                    : ListView(
                        children: [
                          SizedBox(height: height12),
                          deliveryAddress(),
                          SizedBox(height: height12),
                          listItem(),
                          SizedBox(height: height12),
                          deliveryFee(),
                          SizedBox(height: height12),
                          summary(),
                          SizedBox(height: height12),
                        ],
                      ))
          ]),
        ),

        // Bottom Checkout
        bottomNavigationBar: isLoading
            ? Container(width: 0, height: 0)
            : Container(
                width: screenWidth,
                height: height40 * 1.8,
                color: white,
                padding: EdgeInsets.symmetric(
                    horizontal: width20, vertical: height12 - 2),
                child: Row(children: [
                  // Final Order
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total ",
                            style: vietnam400.copyWith(
                                fontSize: font13, color: blackColor)),
                        Text(
                          Helpers.convertToIdr(total),
                          style: vietnam500.copyWith(
                              fontSize: font14, color: secondaryColor),
                        )
                      ],
                    ),
                  ),

                  // Button Order
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () async {
                        FToast().init(context);
                        showLoading();
                        final result = await Provider.of<OrderProvider>(context,
                                listen: false)
                            .checkout(
                                addressId, subtotal, shipping!.cost, total);
                        Navigator.pop(context);
                        if (result != null) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/home", (route) => false);
                          Navigator.pushNamed(context, "/myorder");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => PaymentPage(
                                      paymentUrl: result.paymentUrl!))));
                        } else {
                          Navigator.pushReplacementNamed(
                              context, "/order-failed");
                          FToast().showToast(
                              child: errorToast, gravity: ToastGravity.CENTER);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(width12)),
                        padding: EdgeInsets.symmetric(
                          vertical: height8,
                        ),
                        margin: EdgeInsets.only(
                          left: width20,
                        ),
                        child: Center(
                          child: Text(
                            'Order',
                            style: vietnam500.copyWith(
                                fontSize: font14, color: white),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
      );
    });
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
            "Delivery Address",
            style: vietnam500.copyWith(fontSize: font13, color: primaryColor),
          ),
          SizedBox(
            height: height8,
          ),
          Text(address!.name + " | " + address!.phoneNumber,
              softWrap: true,
              style: vietnam500.copyWith(fontSize: font12, color: blackColor)),
          Text(
            address!.address,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: vietnam400.copyWith(
                height: 1.5, fontSize: font12, color: darkgrey),
          ),
          Text(
            "Kode Pos " + address!.postalCode,
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
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        subtotal = cartProvider.subtotal;
        final carts = cartProvider.carts;
        return Container(
          width: screenWidth,
          color: white,
          padding:
              EdgeInsets.symmetric(horizontal: width24, vertical: height16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Item",
                style:
                    vietnam500.copyWith(fontSize: font13, color: primaryColor),
              ),
              SizedBox(
                height: height8,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: carts.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: height4,
                      thickness: 0.8,
                      color: silver,
                    );
                  },
                  itemBuilder: (context, index) {
                    return itemOrder(
                      carts[index].product!.name!,
                      carts[index].product!.price!,
                      carts[index].quantity!,
                      carts[index].product!.galleries![0].imageUrl!,
                    );
                    // );
                  }),
              SizedBox(
                height: height12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal Order",
                    style: vietnam400.copyWith(
                        fontSize: font12, color: blackColor),
                  ),
                  Text(
                    Helpers.convertToIdr(subtotal),
                    style: vietnam400.copyWith(
                        fontSize: font12, color: primaryColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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

  Widget deliveryFee() {
    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      return Container(
          width: screenWidth,
          color: white,
          padding:
              EdgeInsets.symmetric(vertical: height16, horizontal: width24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shipment",
                style:
                    vietnam500.copyWith(fontSize: font13, color: primaryColor),
              ),
              SizedBox(
                height: height8,
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
                    cartProvider.shipping.name,
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font12, color: blackColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Estimation",
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font12, color: blackColor),
                  ),
                  Text(
                    cartProvider.shipping.estimation + " day(s)",
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
                    Helpers.convertToIdr(cartProvider.shipping.cost),
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font12, color: primaryColor),
                  ),
                ],
              ),
            ],
          ));
    });
  }

  Widget summary() {
    return Consumer<CartProvider>(builder: (
      context,
      cartProvider,
      _,
    ) {
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
                  Helpers.convertToIdr(cartProvider.subtotal),
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
                  Helpers.convertToIdr(cartProvider.shipping.cost),
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
                  Helpers.convertToIdr(total),
                  style: vietnam500.copyWith(
                      height: 1.5, fontSize: font13, color: primaryColor),
                ),
              ],
            ),
          ],
        ),
      );
    });
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
            'Checkout',
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

// Show Loading Animation
  showLoading() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: width32 * 3),
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              content: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width20, vertical: height16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width12),
                  color: white,
                ),
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: primaryColor, size: width12 * 5),
              ),
            ));
  }
}
