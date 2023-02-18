import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoemania/pages/products/product_page.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class ItemProductVertical extends StatelessWidget {
  ItemProductVertical({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.category,
    required this.name,
    required this.price,
  }) : super(key: key);

  int id;
  String name = "";
  String category = "";
  String imageUrl = "";
  num price = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductPage(id: id)));
      },
      child: Container(
        width: screenWidth,
        // margin: EdgeInsets.symmetric(vertical: height4),
        padding: EdgeInsets.symmetric(vertical: height8, horizontal: width24),
        child: Row(children: [
          Container(
            width: width32 * 4,
            height: width32 * 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width8),
                color: silver,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl))),
          ),
          SizedBox(
            width: width16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: vietnam400.copyWith(fontSize: font11, color: gray),
              ),
              SizedBox(
                height: height8,
              ),
              SizedBox(
                width: screenWidth / 2.4,
                child: Text(
                  name,
                  maxLines: 2,
                  // softWrap: true,
                  style:
                      vietnam500.copyWith(fontSize: font12, color: blackColor),
                ),
              ),
              SizedBox(
                height: height8,
              ),
              Text(
                Helpers.convertToIdr(price),
                style: vietnam500.copyWith(
                    fontSize: font12, color: secondaryColor),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class ItemProductVerticalLoading extends StatelessWidget {
  const ItemProductVerticalLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.symmetric(vertical: height4),
      padding: EdgeInsets.symmetric(vertical: height8, horizontal: width24),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: width32 * 4,
          height: width32 * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width8),
            color: silver,
          ),
        ),
        SizedBox(
          width: width16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth / 5.6,
              height: font12,
              color: silver,
            ),
            SizedBox(
              height: height8,
            ),
            Container(
              width: screenWidth / 2.4,
              height: font14,
              color: silver,
            ),
            SizedBox(
              height: height8,
            ),
            Container(
              width: screenWidth / 4,
              height: font13,
              color: silver,
            ),
          ],
        )
      ]),
    );
  }
}
