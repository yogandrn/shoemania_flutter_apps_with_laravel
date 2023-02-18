import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoemania/pages/products/product_page.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class ItemProductGrid extends StatelessWidget {
  ItemProductGrid({
    Key? key,
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.category,
  }) : super(key: key);

  int productId, price;
  String productName, category, imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(id: productId)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width8),
            boxShadow: [
              BoxShadow(
                color: silver,
                offset: Offset(0, 3),
                blurRadius: 12,
              )
            ]),
        child: Stack(children: [
          Column(
            children: [
              Flexible(
                flex: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: silver,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(width8),
                    ),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Flexible(
                flex: 6,
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(
                      vertical: height8, horizontal: width12 + 2),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(width8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(category,
                          style: vietnam300.copyWith(
                            fontSize: font11,
                            height: 1.2,
                            color: gray,
                          )),
                      // SizedBox(
                      //   height: height8 / 1.5,
                      // ),
                      Text(
                        productName,
                        style: vietnam400.copyWith(
                          fontSize: font12,
                          color: blackColor,
                          height: 1.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      // SizedBox(
                      //   height: height8 / 1.5,
                      // ),
                      Text(
                        Helpers.convertToIdr(price),
                        style: vietnam500.copyWith(
                          height: 1.2,
                          fontSize: font12,
                          color: secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class ItemProductGridLoading extends StatelessWidget {
  const ItemProductGridLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(width8)),
      child: Stack(children: [
        Column(
          children: [
            Flexible(
              flex: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: silver,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(width8),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 6,
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(
                    vertical: height8, horizontal: width12 + 2),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(width8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: width32 * 2.5,
                      height: font14,
                      color: silver,
                    ),
                    Container(
                      height: font15,
                      color: silver,
                    ),
                    Container(
                      height: font16,
                      color: silver,
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
