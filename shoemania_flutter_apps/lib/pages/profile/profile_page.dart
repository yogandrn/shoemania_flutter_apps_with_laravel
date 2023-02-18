import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  bool isAuth = false;

  // Toast Error
  Widget errorToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "There is a problem while you're logging out!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
    // authProvider = Provider.of<AuthProvider>(context, listen: false);
    // cartProvider = Provider.of<CartProvider>(context, listen: false);
  }

  checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isAuth = preferences.getBool("isAuth") ?? false;
    await Provider.of<AuthProvider>(context, listen: false).getUserData();
    setState(() {
      isLoading = false;
    });
  }

  Future refreshData() async {
    // isAuth = Provider.of<AuthProvider>(context, listen: false).isAuth;
    await Provider.of<AuthProvider>(context, listen: false).getUserData();
    await Provider.of<CartProvider>(context, listen: false).getCarts();
  }

  @override
  Widget build(BuildContext context) {
    // final _isAuth = Provider.of<AuthProvider>(context, listen: false).isAuth;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
// child: isAuth ? RefreshIndicator(onRefresh: refreshData, child:
//          ListView(
//                       children: [
//                         defaultHeader(),
//                         Container(),
//                         defaultAccountMenu(context),
//                         generalMenu(context)
//                       ],
//                     ),
// ) : ,

        // child: content(),

        child: isLoading
            ? Container(child: loading())
            : RefreshIndicator(
                onRefresh: refreshData,
                // child: content(),
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    return ListView(
                      children: [
                        isAuth ? header() : defaultHeader(),
                        isAuth ? summary(context) : Container(),
                        isAuth
                            ? accountMenu(context)
                            : defaultAccountMenu(context),
                        isAuth
                            ? generalMenu(context)
                            : defaultGeneralMenu(context),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget news() {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: FutureBuilder(builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView();
        }
        return ListView(
          children: [],
        );
      }),
    );
  }

  Widget content() {
    var user = Provider.of<AuthProvider>(context, listen: false).user;
    var cartLength =
        Provider.of<CartProvider>(context, listen: false).carts.length;
    return RefreshIndicator(
      onRefresh: refreshData,
      child: Expanded(
        child: FutureBuilder(
            future:
                Provider.of<AuthProvider>(context, listen: false).getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView(
                  children: [
                    Container(
                      width: screenWidth,
                      color: primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: width24, vertical: height20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/images/default-user.png",
                              fit: BoxFit.cover,
                              width: width32 * 2.5,
                            ),
                            // borderRadius: BorderRadius.circular(height24),
                          ),
                          SizedBox(
                            width: width16,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: screenWidth / 3,
                                height: font18,
                                color: white.withOpacity(0.2),
                              ),
                              SizedBox(
                                height: height6,
                              ),
                              Container(
                                width: screenWidth / 2.5,
                                height: font14,
                                color: white.withOpacity(0.2),
                              ),
                              // Text("${user.name}",
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: vietnam500.copyWith(fontSize: font18, color: white)),
                              // Text(user.email,
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: vietnam400.copyWith(fontSize: font14, color: white)),
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      color: white,
                      padding: EdgeInsets.symmetric(
                        horizontal: width24,
                        vertical: height20,
                      ),
                      margin: EdgeInsets.only(
                        top: height16,
                        bottom: height8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: font24,
                                  height: font24,
                                  color: silver,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: font14 * 2.5,
                                  height: font10,
                                  color: silver,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: font24,
                                height: font24,
                                color: silver,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: font14 * 2.5,
                                height: font10,
                                color: silver,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    accountMenu(context),
                    generalMenu(
                      context,
                    )
                  ],
                );
              } else {
                if (snapshot.error != null) {
                  return Center(
                    child: Text("Something went wrong!"),
                  );
                } else {
                  return Consumer<AuthProvider>(
                      builder: (context, authProvider, _) {
                    return ListView(
                      children: [
                        Container(
                          width: screenWidth,
                          color: primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: width24, vertical: height20),
                          child: Row(
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: authProvider.user.profilePhotoUrl,
                                  fit: BoxFit.cover,
                                  width: width32 * 2.5,
                                ),
                                // borderRadius: BorderRadius.circular(height24),
                              ),
                              SizedBox(
                                width: width16,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(authProvider.user.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: vietnam500.copyWith(
                                          fontSize: font15, color: white)),
                                  SizedBox(
                                    height: height6,
                                  ),
                                  Text(authProvider.user.email,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: vietnam400.copyWith(
                                          fontSize: font13, color: white)),
                                ],
                              ))
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth,
                          color: white,
                          padding: EdgeInsets.symmetric(
                            horizontal: width24,
                            vertical: height20,
                          ),
                          margin: EdgeInsets.only(
                            top: height16,
                            bottom: height8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/cart');
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      authProvider.countCarts.toString(),
                                      style: vietnam500.copyWith(
                                          fontSize: font14 * 2,
                                          color: primaryColor),
                                    ),
                                    Text(
                                      'Carts',
                                      style: vietnam400.copyWith(
                                          fontSize: font13, color: blackColor),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    authProvider.countOrder.toString(),
                                    style: vietnam500.copyWith(
                                        fontSize: font14 * 2,
                                        color: primaryColor),
                                  ),
                                  Text(
                                    'Orders',
                                    style: vietnam400.copyWith(
                                        fontSize: font13, color: blackColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        accountMenu(context),
                        generalMenu(context),
                      ],
                    );
                  });
                }
              }
            }),
      ),
    );
  }

  Widget loading() {
    return ListView(
      children: [
        Container(
          width: screenWidth,
          color: primaryColor,
          padding:
              EdgeInsets.symmetric(horizontal: width24, vertical: height20),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/default-user.png",
                  fit: BoxFit.cover,
                  width: width32 * 2.5,
                ),
                // borderRadius: BorderRadius.circular(height24),
              ),
              SizedBox(
                width: width16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth / 3,
                    height: font15,
                    color: white.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: height6,
                  ),
                  Container(
                    width: screenWidth / 2.5,
                    height: font13,
                    color: white.withOpacity(0.2),
                  ),
                  // Text("${user.name}",
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: vietnam500.copyWith(fontSize: font18, color: white)),
                  // Text(user.email,
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: vietnam400.copyWith(fontSize: font14, color: white)),
                ],
              ))
            ],
          ),
        ),
        Container(
          width: screenWidth,
          color: white,
          padding: EdgeInsets.symmetric(
            horizontal: width24,
            vertical: height20,
          ),
          margin: EdgeInsets.only(
            top: height16,
            bottom: height8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cart');
                },
                child: Column(
                  children: [
                    Container(
                      width: font24,
                      height: font24,
                      color: silver,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: font14 * 2.5,
                      height: font10,
                      color: silver,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: font24,
                    height: font24,
                    color: silver,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: font14 * 2.5,
                    height: font10,
                    color: silver,
                  ),
                ],
              ),
            ],
          ),
        ),
        accountMenu(context),
        generalMenu(
          context,
        )
      ],
    );
  }

  Widget header() {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      var user = authProvider.user;
      return Container(
        width: screenWidth,
        color: primaryColor,
        padding: EdgeInsets.only(
            left: width24, bottom: height20, right: width24, top: height40),
        child: Row(
          children: [
            Container(
              height: width28 * 2,
              width: width28 * 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width32),
                  color: silver,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(user.profilePhotoUrl),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: width16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${user.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: vietnam500.copyWith(fontSize: font13, color: white)),
                SizedBox(
                  height: height4,
                ),
                Text(user.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: vietnam400.copyWith(fontSize: font12, color: white)),
              ],
            ))
          ],
        ),
      );
    });
  }

  Widget defaultHeader() {
    return Container(
        width: screenWidth,
        color: primaryColor,
        padding: EdgeInsets.only(
            left: width24, bottom: height20, right: width24, top: height40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Image.asset(
                "assets/images/default-user.png",
                fit: BoxFit.cover,
                width: width32 * 2.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // width: width32 * 1.5,
                  decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: white, width: 1.2),
                      borderRadius: BorderRadius.circular(width8)),
                  padding: EdgeInsets.symmetric(
                    horizontal: height6,
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        'Login',
                        style: vietnam500.copyWith(
                            fontSize: font12, color: primaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width12,
                ),
                Container(
                  // width: width32 * 1.5,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: white, width: 1.2),
                      borderRadius: BorderRadius.circular(width8)),
                  padding: EdgeInsets.symmetric(horizontal: height6),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text(
                        'Register',
                        style:
                            vietnam400.copyWith(fontSize: font12, color: white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget defaultSummary(BuildContext context) {
    return Container(
      width: screenWidth,
      color: white,
      padding: EdgeInsets.symmetric(
        horizontal: width24,
        vertical: height20,
      ),
      margin: EdgeInsets.only(
        top: height16,
        bottom: height8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
            child: Column(
              children: [
                Text(
                  '0',
                  style: vietnam500.copyWith(
                      fontSize: font14 * 2, color: primaryColor),
                ),
                Text(
                  'Carts',
                  style:
                      vietnam400.copyWith(fontSize: font13, color: blackColor),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '0',
                style: vietnam500.copyWith(
                    fontSize: font14 * 2, color: primaryColor),
              ),
              Text(
                'Orders',
                style: vietnam400.copyWith(fontSize: font13, color: blackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget summary(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Container(
        width: screenWidth,
        color: white,
        padding: EdgeInsets.symmetric(
          horizontal: width24,
          vertical: height20,
        ),
        margin: EdgeInsets.only(
          top: height16,
          bottom: height8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: Column(
                children: [
                  Text(
                    authProvider.countCarts.toString(),
                    style: vietnam500.copyWith(
                        fontSize: font14 * 2, color: primaryColor),
                  ),
                  Text(
                    'Carts',
                    style: vietnam400.copyWith(
                        fontSize: font13, color: blackColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/myorder");
              },
              child: Column(
                children: [
                  Text(
                    authProvider.countOrder.toString(),
                    style: vietnam500.copyWith(
                        fontSize: font14 * 2, color: primaryColor),
                  ),
                  Text(
                    'Orders',
                    style: vietnam400.copyWith(
                        fontSize: font13, color: blackColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget accountMenu(BuildContext context) {
    return Container(
      width: screenWidth,
      color: white,
      padding: EdgeInsets.symmetric(vertical: height16, horizontal: width24),
      margin: EdgeInsets.symmetric(vertical: height8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // button edit profile
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Edit Profile',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/edit-profile");
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
        Divider(
          height: height24,
          color: silver,
          thickness: 1.0,
        ),
        // SizedBox(
        //   height: height12,
        // ),

        // button address menu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Address',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/address");
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
      ]),
    );
  }

  Widget generalMenu(BuildContext context) {
    return Container(
      width: screenWidth,
      color: white,
      padding: EdgeInsets.symmetric(vertical: height16, horizontal: width24),
      margin: EdgeInsets.symmetric(vertical: height8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // button edit profile
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Change Password',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, "/edit-profile");
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
        Divider(
          height: height24,
          color: silver,
          thickness: 1.0,
        ),
        // SizedBox(
        //   height: height12,
        // ),

        // button address menu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Log out',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(width16))),
                    context: context,
                    builder: (context) {
                      return modalConfirmLogout();
                      // }
                    });
                // Navigator.pushNamed(context, "/address");
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
      ]),
    );
  }

  Widget defaultGeneralMenu(BuildContext context) {
    return Container(
      width: screenWidth,
      color: white,
      padding: EdgeInsets.symmetric(vertical: height16, horizontal: width24),
      margin: EdgeInsets.symmetric(vertical: height8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // button edit profile
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Change Password',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, "/edit-profile");
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
        Divider(
          height: height24,
          color: silver,
          thickness: 1.0,
        ),
        // SizedBox(
        //   height: height12,
        // ),

        // button address menu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Log out',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Login required!')));
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
      ]),
    );
  }

  Widget defaultAccountMenu(BuildContext context) {
    return Container(
      width: screenWidth,
      color: white,
      padding: EdgeInsets.symmetric(vertical: height16, horizontal: width24),
      margin: EdgeInsets.symmetric(vertical: height8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // button edit profile
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Edit Profile',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Login required!'),
                  duration: Duration(milliseconds: 1200),
                ));
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
        Divider(
          height: height24,
          color: silver,
          thickness: 1.0,
        ),

        // button address menu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Address',
              style: vietnam400.copyWith(fontSize: font13, color: blackColor),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Login required!'),
                  duration: Duration(milliseconds: 1200),
                ));
                // Navigator.pushNamed(context, "/edit-profile");
              },
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
      ]),
    );
  }

  Widget modalConfirmLogout() {
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
        Text("Log Out?",
            style: vietnam500.copyWith(fontSize: font15, color: blackColor)),
        Image.asset(
          "assets/images/security-error.png",
          width: screenWidth / 2.6,
        ),
        Text("Are you sure want to logout from your account?",
            textAlign: TextAlign.center,
            style: vietnam400.copyWith(fontSize: font12, color: blackColor)),
        SizedBox(
          height: height6,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Button Logout
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  // Navigator.pop(context);
                  FToast().init(context);
                  showLoading();
                  Future.delayed(Duration(milliseconds: 800), () async {
                    final result =
                        await Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                    if (result == true) {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    } else {
                      Navigator.pop(context);
                      FToast().showToast(
                          child: errorToast, gravity: ToastGravity.CENTER);
                    }
                  });
                },
                child: Container(
                  width: screenWidth,
                  height: height40 * 1.1,
                  margin: EdgeInsets.only(right: width12 / 2),
                  padding: EdgeInsets.symmetric(
                      horizontal: width20, vertical: height8),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: primaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(width12)),
                  child: Center(
                    child: Text(
                      'Logout',
                      style: vietnam500.copyWith(
                          fontSize: font14, color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),

            // Button Cancel
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
        ),
      ),
    );
  }
}
