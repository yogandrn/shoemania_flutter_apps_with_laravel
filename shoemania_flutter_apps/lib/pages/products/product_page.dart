import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
import 'package:shoemania/models/cart_model.dart';
import 'package:shoemania/pages/chats/detail_chat_page.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/providers/product_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:shoemania/utils/helpers.dart';
import 'package:shoemania/widgets/modal_cart.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key, required this.id}) : super(key: key);

  int id;
  // int quantity = 1;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;
  int userId = 0;
  int _quantity = 1;
  int _subtotal = 0;
  int max = 0;
  bool _isAuth = false;
  bool isLoading = true;
  Carts? cart;
  Product? product;
//   FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    // fToast = FToast();
    // fToast.init(context);
    checkData();
  }

  @override
  void dispose() {
    _quantity = 1;
    super.dispose();
  }

  checkData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isAuth = preferences.getBool("isAuth") ?? false;
    userId = preferences.getInt("user_id") ?? 0;
    final carts = await Provider.of<CartProvider>(context, listen: false)
        .carts
        .firstWhereOrNull((element) => element.productId == widget.id);
    var product = Provider.of<ProductProvider>(context, listen: false)
        .products
        .firstWhere((element) => element.id == widget.id);
    if (carts != null) {
      setState(() {
        cart = carts;
        max = product.stock! - cart!.quantity!;
      });
    } else {
      setState(() {
        max = product.stock!;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<ProductProvider>(context, listen: false)
        .getProduct(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget Loading
    Widget loading = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularProgressIndicator(
          strokeWidth: 5,
        ),
        SizedBox(
          width: width20,
        ),
        Text(
          "Please wait...",
          style: vietnam400.copyWith(fontSize: font14, color: blackColor),
        ),
      ],
    );

    // Toast Success
    Widget successToast = Container(
      padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width16),
          color: Colors.black.withOpacity(0.88)),
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
          color: Colors.black.withOpacity(0.88)),
      child: Text(
        "Failed to add product!",
        style: vietnam400.copyWith(fontSize: font12, color: white),
      ),
    );

    // Toast Max
    Widget maxQtyToast = Container(
      padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width16),
          color: Colors.black.withOpacity(0.88)),
      child: Text(
        "You have added this item to your shopping cart with the maximum amount",
        textAlign: TextAlign.center,
        style: vietnam400.copyWith(fontSize: font12, color: white),
      ),
    );

    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        var cart = cartProvider.carts
            .firstWhereOrNull((element) => element.productId == widget.id);
        return Consumer<ProductProvider>(
            builder: (context, productProvider, _) {
          var product = productProvider.products
              .firstWhere((product) => product.id == widget.id);

          int index = -1;
          // int quantity = 1;
          // int subtotal = 0;
          return Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(
                child: Column(
                  children: [
                    // Header
                    Container(
                      color: white,
                      height: height40 * 1.5,
                      padding: EdgeInsets.symmetric(horizontal: width12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios_rounded)),
                          SizedBox(
                            width: screenWidth / 1.5,
                            child: Text(
                              product.name!,
                              overflow: TextOverflow.ellipsis,
                              style: publicsans500.copyWith(
                                  fontSize: font16, color: blackColor),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/cart");
                            },
                            child: Icon(
                              BootstrapIcons.cart_check,
                              color: blackColor,
                              size: font24 + 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content Product
                    isLoading
                        ? onLoading()
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: refreshData,
                              child: ListView(
                                // shrinkWrap: true,
                                children: [
                                  // Product Image
                                  Container(
                                    height: screenWidth - 60,
                                    width: screenWidth,
                                    child: PageView.builder(
                                        itemCount: product.galleries!.length,
                                        pageSnapping: true,
                                        controller: PageController(
                                            viewportFraction: 1.0),
                                        onPageChanged: (page) {
                                          setState(() {
                                            currentIndex = page;
                                          });
                                        },
                                        itemBuilder: (context, index) {
                                          return CachedNetworkImage(
                                            imageUrl: product
                                                .galleries![index].imageUrl,
                                            width: screenWidth,
                                            height: screenWidth - 60,
                                            fit: BoxFit.cover,
                                          );
                                        }),
                                  ),

                                  // Product Image Indicator
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                        bottom: height12, top: height12),
                                    color: white,
                                    child: Center(
                                      child: CarouselIndicator(
                                        count:
                                            (product.galleries!.length == 0 ||
                                                    product.galleries!.length ==
                                                        null)
                                                ? 1
                                                : product.galleries!.length,
                                        index: currentIndex,
                                        color: silver,
                                        activeColor: primaryColor,
                                      ),
                                    ),
                                  ),

                                  // Detail Product
                                  Container(
                                    color: white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width24,
                                        vertical: height24),
                                    child: Column(children: [
                                      SizedBox(
                                        width: screenWidth - width24 * 2,
                                        child: Text(
                                          product.name!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: vietnam500.copyWith(
                                              fontSize: font14,
                                              color: blackColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height8,
                                      ),
                                      //Product Price
                                      SizedBox(
                                        width: screenWidth - width24 * 2,
                                        child: Text(
                                          Helpers.convertToIdr(product.price),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: vietnam500.copyWith(
                                              fontSize: font15,
                                              color: secondaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height20,
                                      ),
                                      Container(
                                        width: screenWidth,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width20,
                                            vertical: height16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(width12),
                                          color: Color(0xFFEDEDED),
                                        ),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Category",
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  product.category!.name,
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height6,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Stock",
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  product.stock.toString(),
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height6,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Sold",
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  product.sold.toString(),
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height6,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Weight",
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  product.weight.toString() +
                                                      " gram",
                                                  style: vietnam400.copyWith(
                                                      fontSize: font12,
                                                      color: blackColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: height24,
                                      ),
                                      Text(
                                        product.description!,
                                        softWrap: true,
                                        maxLines: 100,
                                        style: vietnam300.copyWith(
                                            fontSize: font12,
                                            color: blackColor),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              ),
              bottomNavigationBar: Consumer<CartProvider>(
                builder: (context, cartProvider, _) {
                  return Container(
                    width: screenWidth,
                    height: height40 * 1.8,
                    decoration: BoxDecoration(color: white, boxShadow: [
                      BoxShadow(
                          color: gray, offset: Offset(2, 8), blurRadius: 15),
                    ]),
                    padding: EdgeInsets.symmetric(
                        horizontal: width24, vertical: height12 - 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Button Chats
                        GestureDetector(
                          onTap: () {
                            if (_isAuth == false) {
                              showModalLogin();
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailChatPage(product),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: screenHeight,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: primaryColor, width: 1.2),
                                borderRadius:
                                    BorderRadius.circular(width12 - 2)),
                            padding: EdgeInsets.symmetric(
                              vertical: height8,
                              horizontal: width12 + 3,
                            ),
                            child: Icon(
                              BootstrapIcons.chat_dots_fill,
                              color: primaryColor,
                              size: width28,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () async {
                              FToast().init(context);
                              if (cart?.quantity! == product.stock) {
                                FToast().showToast(
                                    child: maxQtyToast,
                                    gravity: ToastGravity.CENTER);
                              } else {
                                if (_isAuth == false) {
                                  showModalLogin();
                                } else {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(width16))),
                                      context: context,
                                      builder: (context) {
                                        return ModalAddToCart(
                                            recentQty: cart?.quantity,
                                            quantity: _quantity,
                                            max: max,
                                            product: product);
                                      });
                                }
                              }
                            },
                            child: Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(width12)),
                              padding: EdgeInsets.symmetric(
                                vertical: height8,
                              ),
                              margin: EdgeInsets.only(
                                left: width16,
                              ),
                              child: Center(
                                child: Text(
                                  'Add to Cart',
                                  style: vietnam500.copyWith(
                                      fontSize: font14, color: white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ));
        });
      },
    );
  }

  Widget indicator(int index) {
    return Container(
      width: currentIndex == index ? width16 : width8 / 2,
      height: height6,
      margin: EdgeInsets.symmetric(
        horizontal: width12 / 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width12 - 2),
        color: currentIndex == index ? primaryColor : silver,
      ),
    );
  }

  showModalLogin() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(width16))),
        builder: (context) {
          return Container(
            width: screenWidth,
            height: screenHeight / 3.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(width16),
              ),
            ),
            padding:
                EdgeInsets.symmetric(horizontal: width20, vertical: height16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "You're not logged in",
                    style: vietnam500.copyWith(
                        fontSize: font14, color: blackColor),
                  ),
                  Image.asset(
                    "assets/images/warning-box.png",
                    width: screenWidth / 2.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(color: primaryColor, width: 1.2),
                              borderRadius: BorderRadius.circular(width12)),
                          padding: EdgeInsets.symmetric(
                            vertical: height6 / 3,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: width8,
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: vietnam500.copyWith(
                                    fontSize: font14, color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: screenWidth / 2.5,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(width12)),
                          padding: EdgeInsets.symmetric(
                            vertical: height6 / 3,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: width8,
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, "/login");
                              },
                              child: Text(
                                'Login',
                                style: vietnam500.copyWith(
                                    fontSize: font14, color: white),
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

  Widget onLoading() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            height: screenWidth - 60,
            width: screenWidth,
            color: silver,
          ),

          // Product Image Indicator
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: height12, top: height12),
            color: white,
            child: Center(
              child: CarouselIndicator(
                count: 3,
                index: currentIndex,
                color: silver,
                activeColor: primaryColor,
              ),
            ),
          ),

          // Detail Product
          Container(
            color: white,
            padding:
                EdgeInsets.symmetric(horizontal: width24, vertical: height24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  width: screenWidth / 1.5, height: font15, color: silver),
              SizedBox(
                height: height8,
              ),
              Container(
                  width: screenWidth / 2.4, height: font16, color: silver),
              SizedBox(
                height: height20,
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: width20, vertical: height16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width12),
                  color: Color(0xFFEDEDED),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                          Container(
                            width: screenWidth / 3,
                            height: font13,
                            color: silver,
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: height24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth,
                    height: font13,
                    color: silver,
                  ),
                  SizedBox(
                    height: height6,
                  ),
                  Container(
                    width: screenWidth,
                    height: font13,
                    color: silver,
                  ),
                  SizedBox(
                    height: height6,
                  ),
                  Container(
                    width: screenWidth,
                    height: font13,
                    color: silver,
                  ),
                  SizedBox(
                    height: height6,
                  ),
                  Container(
                    width: screenWidth,
                    height: font13,
                    color: silver,
                  ),
                  SizedBox(
                    height: height6,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
