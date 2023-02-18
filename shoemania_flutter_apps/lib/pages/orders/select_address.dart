import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/address_model.dart';
import 'package:shoemania/pages/orders/checkout_page.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({Key? key}) : super(key: key);

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  int addressId = 0;
  int selectedIndex = -1;
  String postalCode = "";
  bool isLoading = true;

  // Toast Error
  Widget errorToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Something went wrong!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    setState(() {
      addressId = 0;
      postalCode = "";
      selectedIndex = -1;
    });
    super.dispose();
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<AuthProvider>(context, listen: false).getUserData();
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
                ? Container(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: height4),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return addressLoading();
                        }),
                  )
                : RefreshIndicator(
                    onRefresh: refreshData,
                    child: Consumer<AuthProvider>(
                        builder: (context, authProvider, _) {
                      var addresses = authProvider.addresses;
                      if (addresses.isEmpty) {
                        return Container(
                          width: double.maxFinite,
                          color: backgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/empty-box.png',
                                width: font24 * 6,
                              ),
                              SizedBox(
                                height: height12,
                              ),
                              Text(
                                'No addresses found',
                                style: vietnam500.copyWith(
                                  fontSize: font15,
                                  color: blackColor,
                                ),
                              ),
                              SizedBox(
                                height: height8,
                              ),
                              SizedBox(
                                width: screenWidth / 1.7,
                                child: Text(
                                  'You have not added any addresses yet',
                                  textAlign: TextAlign.center,
                                  style: vietnam400.copyWith(
                                    fontSize: font13,
                                    color: gray,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height12,
                              ),
                              Container(
                                width: screenWidth / 2.4,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.circular(width12)),
                                padding: EdgeInsets.symmetric(
                                  vertical: height6,
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Add Address',
                                      style: vietnam500.copyWith(
                                          fontSize: font14, color: white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: height4),
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            // List Address
                            return address(index, addresses[index]);
                          },
                        );
                      }
                    }),
                  ),
          )
        ],
      )),
      bottomNavigationBar: selectedIndex == -1
          ? Container(
              width: 0,
              height: 0,
            )
          : Consumer<CartProvider>(builder: (context, cartProvider, _) {
              if (cartProvider.carts.isEmpty) {
                return Container(width: 0, height: 0);
              } else {
                return GestureDetector(
                  onTap: () async {
                    FToast().init(context);
                    showLoading();
                    var result =
                        await Provider.of<CartProvider>(context, listen: false)
                            .shipmentRate(postalCode);
                    Navigator.pop(context);
                    if (result > 0) {
                      // Fluttertoast.showToast(msg: result.toString());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CheckOutPage(addressId: addressId)));
                    } else {
                      FToast().showToast(
                        child: errorToast,
                      );
                    }
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
                          'Confirm',
                          style: vietnam500.copyWith(
                              fontSize: font14, color: white),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
    );
    // return Consumer<AuthProvider>(
    //   builder: (context, authProvider, _) {
    //     var addresses = authProvider.addresses;
    //   },
    // );
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
            'Select Address',
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

  Widget address(int index, Address address) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          addressId = address.id;
          postalCode = address.postalCode.toString();
        });
        print(postalCode);
      },
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width8),
            border: Border.all(
                color: index == selectedIndex ? primaryColor : silver,
                width: 1.25),
            color:
                selectedIndex == index ? primaryColor.withOpacity(0.1) : white),
        margin: EdgeInsets.symmetric(horizontal: width12, vertical: height6),
        padding: EdgeInsets.only(
            left: 0, right: width16, top: height16, bottom: height16),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Icon(
                  selectedIndex == index
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  size: font24,
                  color: index == selectedIndex ? primaryColor : silver,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name + " | " + address.phoneNumber,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font13, color: blackColor),
                  ),
                  Text(
                    address.address,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font12, color: darkgrey),
                  ),
                  Text(
                    "Kode Pos " + address.postalCode,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font12, color: darkgrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addressLoading() {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width8),
          border: Border.all(color: silver, width: 1.25),
          color: white),
      margin: EdgeInsets.symmetric(horizontal: width12, vertical: height6),
      padding: EdgeInsets.only(
          left: width16, right: width16, top: height16, bottom: height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth / 2,
            height: font13,
            color: silver,
          ),
          SizedBox(
            height: height4,
          ),
          Container(
            width: screenWidth / 1.5,
            height: font13,
            color: silver,
          ),
          SizedBox(
            height: height4,
          ),
          Container(
            width: screenWidth / 1.5,
            height: font13,
            color: silver,
          ),
        ],
      ),
    );
  }

  // Show Loading
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
