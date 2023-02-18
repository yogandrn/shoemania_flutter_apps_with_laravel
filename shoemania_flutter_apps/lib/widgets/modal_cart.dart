import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/product_model.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class ModalAddToCart extends StatefulWidget {
  ModalAddToCart(
      {Key? key,
      required this.quantity,
      required this.product,
      required this.max,
      this.recentQty})
      : super(key: key);

  int quantity;
  Product product;
  int max;
  int? recentQty;

  @override
  State<ModalAddToCart> createState() => _ModalAddToCartState();
}

class _ModalAddToCartState extends State<ModalAddToCart> {
  int max = 0;

  // Toast Success
  Widget successToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Successfully add to cart",
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
      "Failed to add product!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var restQty =
        widget.recentQty != null ? widget.max - widget.recentQty! : widget.max;
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
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Product Info
        Row(
          children: [
            // Product Image
            Container(
              width: width32 * 2.4,
              height: width32 * 2.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height8),
                  color: silver,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        widget.product.galleries![0].imageUrl),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: width16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Price
                Text(
                  Helpers.convertToIdr(widget.product.price),
                  style: vietnam400.copyWith(
                      fontSize: font13, color: secondaryColor),
                ),
                SizedBox(
                  height: height4,
                ),

                // Product Stock
                Text(
                  "Stock : " + widget.product.stock.toString(),
                  style:
                      vietnam400.copyWith(fontSize: font13, color: blackColor),
                ),
              ],
            ))
          ],
        ),

        // Jika Product Sudah ada di Keranjang
        widget.recentQty != null
            ? Row(
                children: [
                  Container(
                    width: height32,
                    height: height32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width8 - 4),
                        color: success.withOpacity(0.25)),
                    child: Icon(
                      BootstrapIcons.cart_check,
                      color: success,
                    ),
                  ),
                  SizedBox(
                    width: width16,
                  ),
                  Expanded(
                    child: Text(
                        "You have added " +
                            widget.recentQty.toString() +
                            " (pcs) of these items to your shopping cart. ",
                        softWrap: true,
                        style:
                            vietnam300.copyWith(fontSize: font12, color: gray)),
                  )
                ],
              )
            : Container(),
        Divider(height: height24, thickness: 1.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                    child: Text(
                  "Jumlah",
                  style: vietnam400.copyWith(fontSize: font13),
                ))),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width8 - 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Decrement Quantity
                    GestureDetector(
                      onTap: () {
                        if (widget.quantity == 1) {
                          setState(() {
                            widget.quantity == widget.quantity;
                          });
                        } else {
                          setState(() {
                            widget.quantity--;
                          });
                        }
                      },
                      // onTap: (decrement),
                      child: Icon(
                        FontAwesomeIcons.squareMinus,
                        size: font24 + 2,
                        color: widget.quantity == 1 ? gray : blackColor,
                      ),
                    ),

                    // Quantity
                    SizedBox(
                      width: width32 * 2.8,
                      child: Text("${widget.quantity}",
                          textAlign: TextAlign.center,
                          style: vietnam400.copyWith(
                              fontSize: font18, color: blackColor)),
                    ),

                    // Increment Quantity
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.quantity == widget.max) {
                            widget.quantity == widget.quantity;
                          } else {
                            widget.quantity++;
                          }
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.squarePlus,
                        size: font24 + 2,
                        color:
                            widget.quantity == widget.max ? gray : blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: height8,
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

            // Button Add to Cart
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  showLoading();
                  var result =
                      await Provider.of<CartProvider>(context, listen: false)
                          .addtoCart(widget.product.id!, widget.quantity);
                  Navigator.pop(context);
                  if (result == true) {
                    Navigator.pop(context);
                    FToast().showToast(
                        child: successToast, gravity: ToastGravity.CENTER);
                  } else if (result == false) {
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
                      'Add to Cart',
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

class ModalDeleteCart extends StatefulWidget {
  ModalDeleteCart({
    Key? key,
    required this.cartId,
  }) : super(key: key);

  int cartId;

  @override
  State<ModalDeleteCart> createState() => _ModalDeleteCartState();
}

class _ModalDeleteCartState extends State<ModalDeleteCart> {
  // Toast Success
  Widget successToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Successfully delete item from cart",
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
      "Failed to delete product!",
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
        Text("Remove this item?",
            style: vietnam500.copyWith(fontSize: font15, color: blackColor)),
        Image.asset(
          "assets/images/deleted.png",
          width: screenWidth / 2.6,
        ),
        Text("Are you sure want to remove this item ?",
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
                  showLoading();
                  var result =
                      await Provider.of<CartProvider>(context, listen: false)
                          .deleteCart(widget.cartId);
                  Navigator.pop(context);
                  if (result == true) {
                    Navigator.pop(context);
                    FToast().showToast(
                        child: successToast, gravity: ToastGravity.CENTER);
                  } else if (result == false) {
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
                      'Remove',
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
