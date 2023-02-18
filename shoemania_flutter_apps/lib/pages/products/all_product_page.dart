import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/providers/product_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/widgets/item_product_grid.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Column(
          children: [header(), listProducts()],
        )));
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
            'All Products',
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

  Widget listProducts() {
    int _crossAxisCount = screenWidth > 640 ? 3 : 2;
    double _crossAxisSpacing = width12, _mainAxisSpacing = screenWidth / 48;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = height40 * 6.4;
    var _aspectRatio = width / cellHeight;
    return Expanded(
      child: FutureBuilder(
          future: Provider.of<ProductProvider>(context, listen: false)
              .getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return onLoading();
              // return Center(
              //   child: LoadingAnimationWidget.staggeredDotsWave(
              //       color: primaryColor, size: width12 * 5),
              // );
            } else {
              if (snapshot.error != null) {
                return error();
              } else {
                return Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                    var products = productProvider.products;
                    return GridView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: height12, horizontal: width12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _crossAxisCount,
                            mainAxisSpacing: height8,
                            crossAxisSpacing: width8,
                            childAspectRatio: _aspectRatio),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ItemProductGrid(
                            productId: products[index].id!,
                            productName: products[index].name!,
                            price: products[index].price!,
                            imageUrl: products[index].galleries![0].imageUrl,
                            category: products[index].category!.name,
                          );
                        });
                  },
                );
              }
            }
          }),
    );
  }

  Widget error() {
    return Container(
      width: double.maxFinite,
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/opps.png',
            width: font24 * 5,
          ),
          SizedBox(
            height: height12,
          ),
          Text(
            'Something went wrong!',
            style: vietnam400.copyWith(
              fontSize: font14,
              color: gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget onLoading() {
    int _crossAxisCount = screenWidth > 640 ? 3 : 2;
    double _crossAxisSpacing = width12, _mainAxisSpacing = screenWidth / 48;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = height40 * 6.4;
    var _aspectRatio = width / cellHeight;
    return GridView.builder(
        padding: EdgeInsets.symmetric(vertical: height12, horizontal: width12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount,
            mainAxisSpacing: height8,
            crossAxisSpacing: width8,
            childAspectRatio: _aspectRatio),
        itemCount: 6,
        itemBuilder: (context, index) {
          return ItemProductGridLoading();
        });
  }
}
