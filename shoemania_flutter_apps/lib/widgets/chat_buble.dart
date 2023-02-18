import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/models/product_model.dart';
import 'package:shoemania/utils/helpers.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble(
      {Key? key, this.text = '', this.isSender = true, required this.product})
      : super(key: key);

  String text = '';
  bool isSender = true;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: height20),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          product is UninitializedProduct ? SizedBox() : productReview(),
          Row(
              mainAxisAlignment:
                  isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.7),
                    padding: EdgeInsets.symmetric(
                        horizontal: width16, vertical: height12),
                    decoration: BoxDecoration(
                        color: isSender ? backgroundChats2 : backgroundChats1,
                        borderRadius: isSender
                            ? BorderRadius.only(
                                topLeft: Radius.circular(width8),
                                bottomLeft: Radius.circular(width8),
                                bottomRight: Radius.circular(width8),
                              )
                            : BorderRadius.only(
                                topRight: Radius.circular(width8),
                                bottomLeft: Radius.circular(width8),
                                bottomRight: Radius.circular(width8),
                              )),
                    child: Text(
                      text,
                      maxLines: 10,
                      style: vietnam400.copyWith(
                        fontSize: font12,
                      ),
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
  }

  Widget productReview() {
    return Container(
      width: screenWidth * 0.7,
      margin: EdgeInsets.only(bottom: height8),
      padding: EdgeInsets.all(width12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(width8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: width32 * 2,
                height: width32 * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        product.galleries![0].imageUrl),
                  ),
                ),
              ),
              SizedBox(width: width8),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: vietnam400.copyWith(
                              fontSize: font13, color: blackColor)),
                      Text(Helpers.convertToIdr(product.price!),
                          maxLines: 1,
                          style: vietnam400.copyWith(
                              fontSize: font13, color: secondaryColor)),
                    ]),
              ),
            ],
          ),
          SizedBox(
            height: height8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //       color: primaryColor,
              //       borderRadius: BorderRadius.circular(width12)),
              //   padding: EdgeInsets.symmetric(
              //       vertical: height6, horizontal: width12),
              //   child: Center(
              //     child: TextButton(
              //       onPressed: () {},
              //       child: Text(
              //         'See Product',
              //         style:
              //             vietnam500.copyWith(fontSize: font14, color: white),
              //       ),
              //     ),
              //   ),
              // )
              // SizedBox(
              //   width: width8,
              // ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width8)),
                  padding: EdgeInsets.symmetric(
                      vertical: height16, horizontal: width16),
                  side: BorderSide(color: primaryColor),
                ),
                child: Text(
                  'Add to Cart',
                  style: vietnam500.copyWith(
                      fontSize: font12, color: primaryColor),
                ),
              ),
              // SizedBox(
              //   width: width12,
              // ),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width8)),
                    padding: EdgeInsets.symmetric(
                        vertical: height16, horizontal: width16),
                    side: BorderSide(color: primaryColor),
                  ),
                  child: Text(
                    'See Product',
                    style: vietnam500.copyWith(fontSize: font12, color: white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
