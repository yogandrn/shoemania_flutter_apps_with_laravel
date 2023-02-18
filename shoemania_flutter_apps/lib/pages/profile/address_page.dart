import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/address_model.dart';
import 'package:shoemania/pages/profile/edit_address.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // bool _isLoading = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      var addresses = authProvider.addresses;
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Column(
          children: [
            header(),
            Expanded(
              child: addresses.isEmpty
                  ? Container(
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
                              fontSize: font14,
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
                                fontSize: font12,
                                color: gray,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height12,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: height4),
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        // List Address
                        return address(addresses[index]);
                      },
                    ),
            )
          ],
        )),
        bottomNavigationBar: addresses.length > 3
            ? Container(width: 0, height: 0)
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/new-address");
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
                        'Add New Address',
                        style:
                            vietnam500.copyWith(fontSize: font14, color: white),
                      ),
                    ),
                  ),
                ),
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
            'Home Address',
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

  Widget address(Address address) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   selectedIndex = index;
        //   addressId = address.id;
        //   postalCode = address.postalCode.toString();
        // });
        // print(postalCode);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditAddressPage(addressId: address.id)));
      },
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width8), color: white),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: height6),
        padding: EdgeInsets.only(
            left: width20, right: width8, top: height16, bottom: height16),
        child: Row(
          children: [
            Expanded(
              flex: 6,
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
                    maxLines: 5,
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font12, color: darkgrey),
                  ),
                  Text(
                    "Kode Pos " + address.postalCode,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: vietnam400.copyWith(
                        height: 1.5, fontSize: font12, color: darkgrey),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Center(
                  child: Icon(Icons.keyboard_arrow_right_rounded),
                )),
          ],
        ),
      ),
    );
  }
}
