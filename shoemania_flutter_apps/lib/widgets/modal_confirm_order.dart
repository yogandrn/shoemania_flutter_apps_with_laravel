import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/pages/orders/detail_order_page.dart';
import 'package:shoemania/providers/order_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';

class ModalConfirmOrder extends StatefulWidget {
  ModalConfirmOrder({Key? key, required this.id}) : super(key: key);

  int id;

  @override
  State<ModalConfirmOrder> createState() => _ModalConfirmOrderState();
}

class _ModalConfirmOrderState extends State<ModalConfirmOrder> {
  // Toast Success
  Widget successToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Order confirmed successfully!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  // Toast Error
  Widget errorToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Failed to confirm this order!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight / 3.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(width16),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: width20, vertical: height16),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //Title
        Text("Confirm Order?",
            style: vietnam500.copyWith(fontSize: font15, color: blackColor)),
        Image.asset(
          "assets/images/deleted.png",
          width: screenWidth / 2.6,
        ),
        Text("Are you sure want to confirm this order ?",
            textAlign: TextAlign.center,
            style: vietnam400.copyWith(fontSize: font12, color: blackColor)),
        SizedBox(
          height: height6,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Button Cancel
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: screenWidth,
                  height: height40 * 1.1,
                  margin: EdgeInsets.only(right: width12 / 2),
                  padding: EdgeInsets.symmetric(
                      horizontal: width20, vertical: height12 - 2),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: primaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(width12)),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: vietnam500.copyWith(
                          fontSize: font13, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),

            // Button Remove
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  FToast().init(context);
                  showLoading();
                  var result =
                      await Provider.of<OrderProvider>(context, listen: false)
                          .confirmOrder(widget.id);
                  Navigator.pop(context);
                  if (result == 200) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             DetailOrderPage(id: widget.id)));
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, "/home", (route) => false);
                    // Navigator.pushNamed(context, "/myorder");
                    FToast().showToast(
                        child: successToast, gravity: ToastGravity.CENTER);
                  } else {
                    Navigator.pop(context);
                    FToast().showToast(
                        child: errorToast, gravity: ToastGravity.CENTER);
                  }
                },
                child: Container(
                  width: screenWidth,
                  height: height40 * 1.1,
                  margin: EdgeInsets.only(left: width12 / 2),
                  padding: EdgeInsets.symmetric(
                      horizontal: width20, vertical: height12 - 2),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(width12)),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style:
                          vietnam500.copyWith(fontSize: font13, color: white),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ]),
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
              padding:
                  EdgeInsets.symmetric(horizontal: width20, vertical: height16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width16),
                color: white,
              ),
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: primaryColor, size: width12 * 5),
            )));
  }
}
