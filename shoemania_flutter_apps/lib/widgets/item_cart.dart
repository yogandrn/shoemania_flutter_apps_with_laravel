import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/pages/products/product_page.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';
import 'package:shoemania/widgets/modal_cart.dart';

class ItemCart extends StatefulWidget {
  ItemCart({
    Key? key,
    required this.id,
    required this.quantity,
    required this.max,
    required this.productID,
    required this.price,
    required this.productName,
    required this.imageUrl,
  }) : super(key: key);
  int id;
  int quantity;
  int price;
  int max;
  int productID;
  String productName;
  String imageUrl;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height12, horizontal: width16),
      margin: EdgeInsets.symmetric(vertical: height6),
      color: white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductPage(id: widget.productID)));
            },
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: width32 * 2.4,
                height: width32 * 2.4,
                decoration: BoxDecoration(
                    color: silver,
                    borderRadius: BorderRadius.circular(width8),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.imageUrl))),
              ),
              SizedBox(
                width: width12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height6,
                    ),
                    Text(
                      "${widget.productName}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: vietnam400.copyWith(
                          fontSize: font13, color: blackColor),
                    ),
                    SizedBox(
                      height: height8,
                    ),
                    Text(
                      Helpers.convertToIdr(widget.price),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: vietnam500.copyWith(
                          fontSize: font13, color: secondaryColor),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth / 1.65,
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
          Divider(height: height20, thickness: 1, color: silver),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(width16))),
                          builder: (context) {
                            return ModalDeleteCart(cartId: widget.id);
                          });
                    },
                    child: Icon(
                      FontAwesomeIcons.trashCan,
                      size: font20 - 2,
                      color: gray,
                    ),
                  ),
                  SizedBox(width: width20),
                  isLoading
                      ? Container(
                          width: width20 * 3.5,
                          child: Text("Loading...",
                              style: vietnam400.copyWith(
                                  fontSize: font12, color: gray)),
                        )
                      : SizedBox(
                          width: width20,
                        ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (widget.quantity == 1) {
                        setState(() {
                          widget.quantity == widget.quantity;
                        });
                      } else {
                        // setState(() {
                        //   widget.quantity--;
                        // });
                        setState(() {
                          isLoading = true;
                        });
                        final result = await Provider.of<CartProvider>(context,
                                listen: false)
                            .decrement(widget.id);
                        if (result) {
                          setState(() {
                            widget.quantity--;
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            widget.quantity == widget.quantity;
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.squareMinus,
                      size: font20,
                      color: widget.quantity == 1 ? gray : blackColor,
                    ),
                  ),
                  SizedBox(
                    width: width32 * 2.5,
                    child: Text(widget.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: vietnam400.copyWith(
                            fontSize: font16, color: primaryColor)),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.quantity == widget.max) {
                        setState(() {
                          widget.quantity == widget.quantity;
                        });
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        final result = await Provider.of<CartProvider>(context,
                                listen: false)
                            .increment(widget.id);
                        if (result) {
                          setState(() {
                            widget.quantity++;
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            widget.quantity == widget.quantity;
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.squarePlus,
                      size: font20,
                      color: widget.quantity == widget.max ? gray : blackColor,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class LoadingCart extends StatefulWidget {
  const LoadingCart({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingCart> createState() => _LoadingCartState();
}

class _LoadingCartState extends State<LoadingCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height12, horizontal: width16),
      margin: EdgeInsets.symmetric(vertical: height6),
      color: white,
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: width32 * 2.4,
              height: width32 * 2.4,
              decoration: BoxDecoration(
                color: silver,
                borderRadius: BorderRadius.circular(width8),
              ),
            ),
            SizedBox(
              width: width12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: height6,
                  ),
                  Container(
                    color: silver,
                    height: font14,
                  ),
                  SizedBox(
                    height: height8,
                  ),
                  Container(
                    width: screenWidth / 2.5,
                    height: font14,
                    color: silver,
                  ),
                ],
              ),
            )
          ]),
          Divider(height: height20, thickness: 1, color: silver),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: font24,
                height: font24,
                color: silver,
              ),
              SizedBox(
                width: width20,
              ),
              Container(
                width: screenWidth / 3.2,
                height: font24,
                color: silver,
              )
            ],
          )
        ],
      ),
    );
  }
}
