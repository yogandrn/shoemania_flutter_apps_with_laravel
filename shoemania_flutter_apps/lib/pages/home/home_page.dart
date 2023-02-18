import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/pages/products/search_product_page.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/product_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/widgets/item_product_horizontal.dart';
import 'package:shoemania/widgets/item_product_vertical.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  Future<void> _refreshData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getPopularProducts();
    await Provider.of<ProductProvider>(context, listen: false).getNewProducts();
  }

  fetchProduct() async {
    final products =
        Provider.of<ProductProvider>(context, listen: false).products;
    if (products.isNotEmpty && products.length > 0) {
      return;
    }
    await Provider.of<ProductProvider>(context, listen: false).getAllProducts();
  }

  getUser() async {
    await Provider.of<AuthProvider>(context, listen: false).getUserData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
    // getUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.text = "";
    _searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: confirmExit,
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: SafeArea(
              child: Column(
                children: [
                  header(),
                  Expanded(
                    child: ListView(children: [
                      // SizedBox(
                      //   height: height16,
                      // ),
                      // searchBar(),
                      SizedBox(
                        height: height20,
                      ),
                      popularProducts(),
                      SizedBox(
                        height: height20,
                      ),
                      newProducts(),
                    ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height16, horizontal: width24),
      color: primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: searchBar(),
              ),
              SizedBox(width: width20),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/cart");
                  },
                  child: Icon(
                    BootstrapIcons.cart3,
                    color: white,
                    size: font24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: width24),
      height: height20 * 1.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width8),
        color: white,
      ),
      padding: EdgeInsets.symmetric(horizontal: width8 - 4),
      child: TextField(
        controller: _searchController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
        style: vietnam400.copyWith(fontSize: font12, color: blackColor),
        decoration: InputDecoration(
            filled: false,
            fillColor: white,
            contentPadding: EdgeInsets.symmetric(
                vertical: height6, horizontal: width12 + 1),
            hintText: 'Search products or category',
            hintStyle: vietnam400.copyWith(fontSize: font12, color: gray),
            border: InputBorder.none,
            // border: OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.transparent, width: 0),
            //     borderRadius: BorderRadius.circular(width8)),
            suffixIcon: Icon(Icons.search_rounded)),
        onSubmitted: (value) {
          if (value.isEmpty) {
            return;
          }
          _searchController.text = "";
          _searchController.clear();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchProductPage(keyword: value)));
        },
      ),
    );
  }

  Widget popularProducts() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width24),
            child: Text(
              'Popular Products',
              style: vietnam500.copyWith(
                color: blackColor,
                fontSize: font18,
              ),
            ),
          ),
          Container(
            height: height40 * 6.4,
            child: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .getPopularProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      padding: EdgeInsets.symmetric(horizontal: width12),
                      itemBuilder: (context, index) {
                        return ItemProductHorizontalLoading();
                      });
                } else {
                  if (snapshot.error != null) {
                    return Center(
                      child: Text(
                        'Something went wrong!',
                        style: publicsans500.copyWith(
                            fontSize: font13, color: gray),
                      ),
                    );
                  } else {
                    return Consumer<ProductProvider>(
                        builder: (context, productProvider, _) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: width16),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: productProvider.popularProducts.length,
                              itemBuilder: (context, index) {
                                return ItemProductHorizontal(
                                  id: productProvider
                                      .popularProducts[index].id!,
                                  name: productProvider
                                      .popularProducts[index].name!,
                                  imageUrl: productProvider
                                      .popularProducts[index]
                                      .galleries![0]
                                      .imageUrl,
                                  price: productProvider
                                      .popularProducts[index].price!,
                                  category: productProvider
                                      .popularProducts[index].category!.name,
                                );
                              }),
                          lastIndexHorizontal(),
                        ],
                      );
                    });
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget lastIndexHorizontal() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/allproduct');
      },
      child: Container(
        width: width32 * 5,
        margin: EdgeInsets.symmetric(horizontal: width8, vertical: height12),
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: silver,
          //   width: 1.4,
          // ),
          color: white,
          borderRadius: BorderRadius.circular(width8),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                BootstrapIcons.arrow_right_circle_fill,
                color: blackColor,
                size: font20,
              ),
              SizedBox(
                height: height6,
              ),
              Text(
                "See more",
                style: vietnam400.copyWith(fontSize: font12, color: blackColor),
              ),
            ]),
      ),
    );
  }

  Widget newProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width24),
          child: Text(
            'New Arrivals',
            style: vietnam500.copyWith(
              color: blackColor,
              fontSize: font18,
            ),
          ),
        ),
        Container(
          child: FutureBuilder(
            future: Provider.of<ProductProvider>(context, listen: false)
                .getNewProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: height4),
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ItemProductVerticalLoading();
                    });
              } else {
                if (snapshot.error != null) {
                  return Center(
                    child: Text(
                      'Something went wrong!',
                      style:
                          publicsans500.copyWith(fontSize: font13, color: gray),
                    ),
                  );
                } else {
                  return Consumer<ProductProvider>(
                      builder: (context, productProvider, _) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: height4),
                        scrollDirection: Axis.vertical,
                        itemCount: productProvider.newProducts.length,
                        itemBuilder: (context, index) {
                          return ItemProductVertical(
                            id: productProvider.newProducts[index].id!,
                            name: productProvider.newProducts[index].name!,
                            imageUrl: productProvider
                                .newProducts[index].galleries![0].imageUrl,
                            price: productProvider.newProducts[index].price!,
                            category: productProvider
                                .newProducts[index].category!.name,
                          );
                        });
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Future<bool> confirmExit() async {
    return await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(width16))),
        context: context,
        builder: (context) {
          return Container(
            width: screenWidth,
            height: screenHeight / 3.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(width16),
              ),
            ),
            padding:
                EdgeInsets.symmetric(horizontal: width20, vertical: height16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Title
                  Text("Confirm Exit",
                      style: vietnam500.copyWith(
                          fontSize: font15, color: blackColor)),
                  Image.asset(
                    "assets/images/exit.jpg",
                    width: screenWidth / 2.5,
                  ),
                  Text("Are you sure want to exit the application?",
                      textAlign: TextAlign.center,
                      style: vietnam400.copyWith(
                          fontSize: font12, color: blackColor)),
                  SizedBox(
                    height: height6,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Button Exit
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            width: screenWidth,
                            height: height40 * 1.1,
                            margin: EdgeInsets.only(right: width12 / 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: width20, vertical: height8),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: primaryColor, width: 1.2),
                                borderRadius: BorderRadius.circular(width12)),
                            child: Center(
                              child: Text(
                                'Exit',
                                style: vietnam500.copyWith(
                                    fontSize: font13, color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Button Cancel
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Container(
                            width: screenWidth,
                            height: height40 * 1.1,
                            margin: EdgeInsets.only(left: width12 / 2),
                            padding: EdgeInsets.symmetric(
                                horizontal: width20, vertical: height8),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(width12)),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: vietnam500.copyWith(
                                    fontSize: font13, color: white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
          );
        });
  }
}
