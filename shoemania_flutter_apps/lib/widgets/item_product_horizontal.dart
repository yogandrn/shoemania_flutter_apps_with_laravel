import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoemania/pages/products/product_page.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class ItemProductHorizontal extends StatelessWidget {
  ItemProductHorizontal({
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
          width: width32 * 6,
          margin: EdgeInsets.symmetric(horizontal: width8, vertical: height12),
          decoration: BoxDecoration(
            // border: Border.all(color: primaryColor, width: 1.15),
            borderRadius: BorderRadius.circular(width8),
            boxShadow: [
              BoxShadow(
                color: silver,
                offset: Offset(0, 3),
                blurRadius: 12,
              )
            ],
          ),
          child: Stack(
            children: [
              Column(children: [
                Flexible(
                  flex: 9,
                  child: Container(
                    decoration: BoxDecoration(
                        color: silver,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(width8),
                        ),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(imageUrl),
                            fit: BoxFit.cover)),
                  ),
                ),
                Flexible(
                    flex: 5,
                    child: Container(
                      width: screenWidth,
                      padding: EdgeInsets.all(width8 + 2),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(width8),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '$category',
                            style: vietnam400.copyWith(
                                fontSize: font10, color: gray),
                          ),
                          Text(
                            '$name',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: vietnam500.copyWith(
                                fontSize: font12, color: blackColor),
                          ),
                          Text(
                            Helpers.convertToIdr(price),
                            style: vietnam500.copyWith(
                                fontSize: font12, color: secondaryColor),
                          )
                        ],
                      ),
                    ))
              ]),
            ],
          )
          // Center(
          //     child: Text(
          //   '1',
          //   style: vietnam600.copyWith(fontSize: font24 + 6, color: primaryColor),
          // )),
          ),
    );
  }
}

class ItemProductHorizontalLoading extends StatelessWidget {
  const ItemProductHorizontalLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width32 * 6,
        margin: EdgeInsets.symmetric(horizontal: width8, vertical: height12),
        decoration: BoxDecoration(
          // border: Border.all(color: primaryColor, width: 1.15),
          borderRadius: BorderRadius.circular(width8),
          // boxShadow: [
          //   BoxShadow(color: silver, offset: Offset(0, 2), blurRadius: 5)
          // ],
        ),
        child: Stack(
          children: [
            Column(children: [
              Flexible(
                flex: 9,
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
                  flex: 5,
                  child: Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(width8 + 2),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(width8),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: width32 * 2,
                          height: font12,
                          color: silver,
                        ),
                        SizedBox(
                          height: height4 / 2,
                        ),
                        Container(
                          width: width32 * 5,
                          height: font14,
                          color: silver,
                        ),
                        SizedBox(
                          height: height4 / 2,
                        ),
                        Container(
                          width: width32 * 4,
                          height: font13,
                          color: silver,
                        ),
                      ],
                    ),
                  ))
            ]),
          ],
        )
        // Center(
        //     child: Text(
        //   '1',
        //   style: vietnam600.copyWith(fontSize: font24 + 6, color: primaryColor),
        // )),
        );
  }
}
