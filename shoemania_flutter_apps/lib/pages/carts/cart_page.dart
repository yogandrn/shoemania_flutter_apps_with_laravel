import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';
import 'package:shoemania/widgets/item_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isAuth = false;
  bool isLoading = true;

  Future<void> _onRefresh() async {
    await Provider.of<CartProvider>(context, listen: false).getCarts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _isAuth = Provider.of<AuthProvider>(context, listen: false).isAuth;
    checkAuth();
  }

  checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isAuth = preferences.getBool("isAuth") ?? false;
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshData() async {
    await Provider.of<CartProvider>(context, listen: false).getCarts();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCarts();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: isLoading
              ? Column(
                  children: [header(), loading()],
                )
              : Column(
                  children: [
                    header(),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: refreshData,
                        child:
                            // Jika belum login
                            !_isAuth
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Login Required!',
                                        style: vietnam500.copyWith(
                                          fontSize: font15,
                                          color: blackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height12,
                                      ),
                                      Image.asset(
                                        'assets/images/warning-box.png',
                                        width: font24 * 6,
                                      ),
                                      SizedBox(
                                        height: height12,
                                      ),
                                      SizedBox(
                                        width: screenWidth / 1.7,
                                        child: Text(
                                          'Please login to access your shopping cart',
                                          textAlign: TextAlign.center,
                                          style: vietnam400.copyWith(
                                            fontSize: font12,
                                            color: gray,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/login");
                                        },
                                        child: Container(
                                          width: screenWidth / 2.2,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width8)),
                                          padding: EdgeInsets.symmetric(
                                            vertical: height12,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Login',
                                              style: vietnam500.copyWith(
                                                fontSize: font13,
                                                color: white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height12,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/register");
                                        },
                                        child: Container(
                                          width: screenWidth / 2.2,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: primaryColor,
                                                  width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width8)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: height12),
                                          child: Center(
                                            child: Text(
                                              'Register',
                                              style: vietnam400.copyWith(
                                                  fontSize: font13,
                                                  color: primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : FutureBuilder(
                                    future: Provider.of<CartProvider>(context,
                                            listen: false)
                                        .getCarts(),
                                    builder: (context, snapshot) {
                                      // Jika loading tampilkan widget loading
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return loading();
                                      } else {
                                        //Jika error tampilkan pesan error
                                        if (snapshot.error != null) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  "assets/images/went-wring.png"),
                                              SizedBox(
                                                height: height16,
                                              ),
                                              Text(
                                                'Something went wrong!',
                                                style: publicsans500.copyWith(
                                                    fontSize: font13,
                                                    color: gray),
                                              ),
                                            ],
                                          );
                                        } else {
                                          // Jika tidak ada error tampilkan data
                                          return Consumer<CartProvider>(builder:
                                              (context, cartProvider, _) {
                                            if (cartProvider.carts.length ==
                                                0) {
                                              return empty();
                                            } else {
                                              return Container(
                                                child: ListView.builder(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: height8),
                                                    itemCount: cartProvider
                                                        .carts.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ItemCart(
                                                        id: cartProvider
                                                            .carts[index].id!,
                                                        productID: cartProvider
                                                            .carts[index]
                                                            .productId!,
                                                        quantity: cartProvider
                                                            .carts[index]
                                                            .quantity!,
                                                        max: cartProvider
                                                            .carts[index]
                                                            .product!
                                                            .stock!,
                                                        price: cartProvider
                                                            .carts[index]
                                                            .product!
                                                            .price!,
                                                        productName:
                                                            cartProvider
                                                                .carts[index]
                                                                .product!
                                                                .name!,
                                                        imageUrl: cartProvider
                                                            .carts[index]
                                                            .product!
                                                            .galleries![0]
                                                            .imageUrl!,
                                                      );
                                                    }),
                                              );
                                            }
                                          });
                                        }
                                      }
                                    },
                                  ),
                      ),
                    )
                  ],
                )),

      // Bottom Checkout
      bottomNavigationBar: isLoading
          ? Container(width: 0, height: 0)
          : Consumer<CartProvider>(builder: (context, cartProvider, _) {
              if (cartProvider.carts.isEmpty) {
                return Container(width: 0, height: 0);
              } else {
                return Container(
                  width: screenWidth,
                  height: height40 * 1.8,
                  color: white,
                  padding: EdgeInsets.symmetric(
                      horizontal: width20, vertical: height12 - 2),
                  child: Row(children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Subtotal ",
                              style: vietnam400.copyWith(
                                  fontSize: font13, color: blackColor)),
                          Text(
                            Helpers.convertToIdr(cartProvider.subtotal),
                            style: vietnam500.copyWith(
                                fontSize: font14, color: secondaryColor),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () {
                          // await Provider.of<AuthProvider>(context,
                          //         listen: false)
                          //     .getAddress();
                          Navigator.pushNamed(context, "/select-address");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(width12)),
                          padding: EdgeInsets.symmetric(
                            vertical: height8,
                          ),
                          margin: EdgeInsets.only(
                            left: width20,
                          ),
                          child: Center(
                            child: Text(
                              'Check Out',
                              style: vietnam500.copyWith(
                                  fontSize: font14, color: white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                );
              }
            }),
    );
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
            'Shopping Carts',
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

  Widget loading() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: height8),
      children: [
        LoadingCart(),
        LoadingCart(),
        LoadingCart(),
      ],
    );
  }

  Widget empty() {
    return Container(
      width: double.maxFinite,
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty-cart.png',
            width: font24 * 6,
          ),
          SizedBox(
            height: height12,
          ),
          Text(
            'Cart is empty',
            style: vietnam500.copyWith(
              fontSize: font14,
              color: blackColor,
            ),
          ),
          SizedBox(
            height: height6,
          ),
          SizedBox(
            width: screenWidth / 1.7,
            child: Text(
              'You do not have any items in your shopping cart',
              textAlign: TextAlign.center,
              style: vietnam400.copyWith(
                fontSize: font12,
                color: gray,
              ),
            ),
          ),
          SizedBox(
            height: height12,
          ),
          Container(
            width: screenWidth / 2.5,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(width12)),
            padding: EdgeInsets.symmetric(
              vertical: height6,
            ),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/allproduct');
                },
                child: Text(
                  'Explore Now',
                  style: vietnam500.copyWith(fontSize: font13, color: white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
