import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/providers/order_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/widgets/item_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = false;

  Future<void> refreshData() async {
    await Provider.of<OrderProvider>(context, listen: false).getMyOrder();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
              child: Column(
            children: [
              header(),
              tabBar(),
              tabBarView(),
            ],
          )),
        ));
  }

  Widget tabBar() {
    return Container(
      color: white,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
            // controller: _tabController,
            labelColor: primaryColor,
            labelPadding:
                EdgeInsets.symmetric(horizontal: width20, vertical: height4),
            labelStyle: vietnam500.copyWith(
              fontSize: font13,
            ),
            unselectedLabelColor: Colors.black.withOpacity(0.5),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primaryColor,
            // indicator:
            //     CircleTabIndicator(color: primary, radius: 5),
            tabs: [
              Container(child: Tab(text: "Pending")),
              Container(child: Tab(text: "On Process")),
              Container(child: Tab(text: "On Delivery")),
              Container(child: Tab(text: "Success")),
              Container(child: Tab(text: "Canceled")),
              // SizedBox(width: _width / 2, child: Tab(text: "Past Order")),
            ]),
      ),
    );
  }

  Widget tabBarView() {
    return Expanded(
      child: TabBarView(
        children: [
          // Pending Transacrtions
          FutureBuilder(
              future: Provider.of<OrderProvider>(context, listen: false)
                  .getMyOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: primaryColor, size: width8 * 5),
                  );
                } else {
                  if (snapshot.error != null) {
                    return Container(
                      width: double.maxFinite,
                      color: backgroundColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/opps.png',
                              width: font24 * 6,
                            ),
                            SizedBox(
                              height: height12,
                            ),
                            SizedBox(
                              width: screenWidth / 1.7,
                              child: Text(
                                'Something went wrong!',
                                textAlign: TextAlign.center,
                                style: vietnam400.copyWith(
                                  fontSize: font14,
                                  color: gray,
                                ),
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: refreshData,
                      child: Consumer<OrderProvider>(
                        builder: (context, orderProvider, _) {
                          var pendingOrders = orderProvider.pendingOrders;
                          if (pendingOrders.isEmpty) {
                            return Container(
                              width: double.maxFinite,
                              color: backgroundColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty-order.png',
                                      width: font24 * 6,
                                    ),
                                    SizedBox(
                                      height: height12,
                                    ),
                                    Text(
                                      'Nothing is here',
                                      style: vietnam500.copyWith(
                                        fontSize: font14,
                                        color: blackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height8,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 1.7,
                                      child: Text(
                                        'You don\'t have any ongoing orders',
                                        textAlign: TextAlign.center,
                                        style: vietnam400.copyWith(
                                          fontSize: font12,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          } else {
                            return ListView.builder(
                                padding:
                                    EdgeInsets.symmetric(vertical: height8),
                                itemCount: pendingOrders.length,
                                itemBuilder: (context, index) {
                                  return ItemOrder(
                                    orderId: pendingOrders[index].id!,
                                    createdAt: pendingOrders[index].createdAt!,
                                    status: pendingOrders[index].status!,
                                    total: pendingOrders[index].total!,
                                    imageUrl: pendingOrders[index]
                                        .items![0]
                                        .product!
                                        .galleries![0]
                                        .imageUrl!,
                                  );
                                  // return Container(
                                  //     margin: EdgeInsets.all(6),
                                  //     padding: EdgeInsets.all(12),
                                  //     color: silver,
                                  //     child: Text(index.toString()));
                                });
                          }
                          // return ListView.builder(
                          //     itemCount: 5,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //           margin: EdgeInsets.all(6),
                          //           padding: EdgeInsets.all(12),
                          //           color: silver,
                          //           child: Text(index.toString()));
                          //     });
                        },
                      ),
                    );
                  }
                }
              }),

          // On Process Transaction
          FutureBuilder(
              future: Provider.of<OrderProvider>(context, listen: false)
                  .getMyOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: primaryColor, size: width8 * 5),
                  );
                } else {
                  if (snapshot.error != null) {
                    return Container(
                      width: double.maxFinite,
                      color: backgroundColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/opps.png',
                              width: font24 * 6,
                            ),
                            SizedBox(
                              height: height12,
                            ),
                            SizedBox(
                              width: screenWidth / 1.7,
                              child: Text(
                                'Something went wrong!',
                                textAlign: TextAlign.center,
                                style: vietnam400.copyWith(
                                  fontSize: font13,
                                  color: gray,
                                ),
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: refreshData,
                      child: Consumer<OrderProvider>(
                        builder: (context, orderProvider, _) {
                          var onProcessOrders = orderProvider.onProcessOrders;
                          if (onProcessOrders.isEmpty) {
                            return Container(
                              width: double.maxFinite,
                              color: backgroundColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty-order.png',
                                      width: font24 * 6,
                                    ),
                                    SizedBox(
                                      height: height12,
                                    ),
                                    Text(
                                      'Nothing is here',
                                      style: vietnam500.copyWith(
                                        fontSize: font14,
                                        color: blackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height8,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 1.7,
                                      child: Text(
                                        'You don\'t have any transaction histories',
                                        textAlign: TextAlign.center,
                                        style: vietnam300.copyWith(
                                          fontSize: font12,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          } else {
                            return ListView.builder(
                                padding:
                                    EdgeInsets.symmetric(vertical: height8),
                                itemCount: onProcessOrders.length,
                                itemBuilder: (context, index) {
                                  return ItemOrder(
                                    orderId: onProcessOrders[index].id!,
                                    createdAt:
                                        onProcessOrders[index].createdAt!,
                                    status: onProcessOrders[index].status!,
                                    total: onProcessOrders[index].total!,
                                    imageUrl: onProcessOrders[index]
                                        .items![0]
                                        .product!
                                        .galleries![0]
                                        .imageUrl!,
                                  );
                                });
                          }
                        },
                      ),
                    );
                  }
                }
              }),

          // On Delivery Transaction
          FutureBuilder(
              future: Provider.of<OrderProvider>(context, listen: false)
                  .getMyOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: primaryColor, size: width8 * 5),
                  );
                } else {
                  if (snapshot.error != null) {
                    return Container(
                      width: double.maxFinite,
                      color: backgroundColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/opps.png',
                              width: font24 * 6,
                            ),
                            SizedBox(
                              height: height12,
                            ),
                            SizedBox(
                              width: screenWidth / 1.7,
                              child: Text(
                                'Something went wrong!',
                                textAlign: TextAlign.center,
                                style: vietnam400.copyWith(
                                  fontSize: font13,
                                  color: gray,
                                ),
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: refreshData,
                      child: Consumer<OrderProvider>(
                        builder: (context, orderProvider, _) {
                          var onDeliveryOrders = orderProvider.onDeliveryOrders;
                          if (onDeliveryOrders.isEmpty) {
                            return Container(
                              width: double.maxFinite,
                              color: backgroundColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty-order.png',
                                      width: font24 * 6,
                                    ),
                                    SizedBox(
                                      height: height12,
                                    ),
                                    Text(
                                      'Nothing is here',
                                      style: vietnam500.copyWith(
                                        fontSize: font14,
                                        color: blackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height8,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 1.7,
                                      child: Text(
                                        'You don\'t have any transaction histories',
                                        textAlign: TextAlign.center,
                                        style: vietnam300.copyWith(
                                          fontSize: font12,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          } else {
                            return ListView.builder(
                                padding:
                                    EdgeInsets.symmetric(vertical: height8),
                                itemCount: onDeliveryOrders.length,
                                itemBuilder: (context, index) {
                                  return ItemOrder(
                                    orderId: onDeliveryOrders[index].id!,
                                    createdAt:
                                        onDeliveryOrders[index].createdAt!,
                                    status: onDeliveryOrders[index].status!,
                                    total: onDeliveryOrders[index].total!,
                                    imageUrl: onDeliveryOrders[index]
                                        .items![0]
                                        .product!
                                        .galleries![0]
                                        .imageUrl!,
                                  );
                                });
                          }
                        },
                      ),
                    );
                  }
                }
              }),

          // Success Transaction
          FutureBuilder(
              future: Provider.of<OrderProvider>(context, listen: false)
                  .getMyOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: primaryColor, size: width8 * 5),
                  );
                } else {
                  if (snapshot.error != null) {
                    return Container(
                      width: double.maxFinite,
                      color: backgroundColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/opps.png',
                              width: font24 * 6,
                            ),
                            SizedBox(
                              height: height12,
                            ),
                            SizedBox(
                              width: screenWidth / 1.7,
                              child: Text(
                                'Something went wrong!',
                                textAlign: TextAlign.center,
                                style: vietnam400.copyWith(
                                  fontSize: font13,
                                  color: gray,
                                ),
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: refreshData,
                      child: Consumer<OrderProvider>(
                        builder: (context, orderProvider, _) {
                          var successOrders = orderProvider.successOrders;
                          if (successOrders.isEmpty) {
                            return Container(
                              width: double.maxFinite,
                              color: backgroundColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty-order.png',
                                      width: font24 * 6,
                                    ),
                                    SizedBox(
                                      height: height12,
                                    ),
                                    Text(
                                      'Nothing is here',
                                      style: vietnam500.copyWith(
                                        fontSize: font14,
                                        color: blackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height8,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 1.7,
                                      child: Text(
                                        'You don\'t have any transaction histories',
                                        textAlign: TextAlign.center,
                                        style: vietnam300.copyWith(
                                          fontSize: font12,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          } else {
                            return ListView.builder(
                                padding:
                                    EdgeInsets.symmetric(vertical: height8),
                                itemCount: successOrders.length,
                                itemBuilder: (context, index) {
                                  return ItemOrder(
                                    orderId: successOrders[index].id!,
                                    createdAt: successOrders[index].createdAt!,
                                    status: successOrders[index].status!,
                                    total: successOrders[index].total!,
                                    imageUrl: successOrders[index]
                                        .items![0]
                                        .product!
                                        .galleries![0]
                                        .imageUrl!,
                                  );
                                });
                          }
                        },
                      ),
                    );
                  }
                }
              }),

          // Cancelled Transaction
          FutureBuilder(
              future: Provider.of<OrderProvider>(context, listen: false)
                  .getMyOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: primaryColor, size: width8 * 5),
                  );
                } else {
                  if (snapshot.error != null) {
                    return Container(
                      width: double.maxFinite,
                      color: backgroundColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/opps.png',
                              width: font24 * 6,
                            ),
                            SizedBox(
                              height: height12,
                            ),
                            SizedBox(
                              width: screenWidth / 1.7,
                              child: Text(
                                'Something went wrong!',
                                textAlign: TextAlign.center,
                                style: vietnam400.copyWith(
                                  fontSize: font13,
                                  color: gray,
                                ),
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: refreshData,
                      child: Consumer<OrderProvider>(
                        builder: (context, orderProvider, _) {
                          var cancelledOrders = orderProvider.cancelledOrders;
                          if (cancelledOrders.isEmpty) {
                            return Container(
                              width: double.maxFinite,
                              color: backgroundColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/empty-order.png',
                                      width: font24 * 6,
                                    ),
                                    SizedBox(
                                      height: height12,
                                    ),
                                    Text(
                                      'Nothing is here',
                                      style: vietnam500.copyWith(
                                        fontSize: font14,
                                        color: blackColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height8,
                                    ),
                                    SizedBox(
                                      width: screenWidth / 1.7,
                                      child: Text(
                                        'You don\'t have any transaction histories',
                                        textAlign: TextAlign.center,
                                        style: vietnam300.copyWith(
                                          fontSize: font12,
                                          color: gray,
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          } else {
                            return ListView.builder(
                                padding:
                                    EdgeInsets.symmetric(vertical: height8),
                                itemCount: cancelledOrders.length,
                                itemBuilder: (context, index) {
                                  return ItemOrder(
                                    orderId: cancelledOrders[index].id!,
                                    createdAt:
                                        cancelledOrders[index].createdAt!,
                                    status: cancelledOrders[index].status!,
                                    total: cancelledOrders[index].total!,
                                    imageUrl: cancelledOrders[index]
                                        .items![0]
                                        .product!
                                        .galleries![0]
                                        .imageUrl!,
                                  );
                                });
                          }
                          // return ListView.builder(
                          //     itemCount: 5,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //           margin: EdgeInsets.all(6),
                          //           padding: EdgeInsets.all(12),
                          //           color: silver,
                          //           child: Text(index.toString()));
                          //     });
                        },
                      ),
                    );
                  }
                }
              }),
        ],
      ),
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
            'Order History',
            style: publicsans600.copyWith(fontSize: font15, color: blackColor),
          ),
          Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
