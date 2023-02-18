import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/providers/product_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/widgets/item_product_grid.dart';

class SearchProductPage extends StatefulWidget {
  SearchProductPage({Key? key, required this.keyword}) : super(key: key);

  String keyword;

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.text = widget.keyword;
    searchData();
  }

  @override
  void dispose() {
    _searchController.text = "";
    _searchController.clear();
    super.dispose();
  }

  Future<void> searchData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<ProductProvider>(context, listen: false)
        .searchProduct(_searchController.text);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
          children: [
            header(),
            isLoading ? loading() : listProducts(),
          ],
        )));
  }

  Widget header() {
    return Container(
      color: primaryColor,
      padding: EdgeInsets.fromLTRB(width12, height16, width24, height16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: white,
              )),
          SizedBox(
            width: width16,
          ),
          Expanded(
            child: searchBar(),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: width24),
      height: height20 * 2.0,
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
                vertical: height12, horizontal: width12 + 2),
            hintText: 'Search products or category',
            hintStyle: vietnam400.copyWith(fontSize: font13, color: gray),
            border: InputBorder.none,
            // border: OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.transparent, width: 0),
            //     borderRadius: BorderRadius.circular(width8)),
            suffixIcon: Icon(Icons.search_rounded)),
        onSubmitted: (value) {
          searchData();
        },
      ),
    );
  }

  Widget loading() {
    return Expanded(
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: primaryColor, size: width8 * 5),
      ),
    );
  }

  Widget listProducts() {
    int _crossAxisCount = screenWidth > 640 ? 3 : 2;
    double _crossAxisSpacing = width12, _mainAxisSpacing = screenWidth / 48;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = height40 * 6.5;
    var _aspectRatio = width / cellHeight;
    return Expanded(
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          var products = productProvider.searchedProducts;
          if (products.isEmpty) {
            return empty();
          }
          return GridView.builder(
              padding:
                  EdgeInsets.symmetric(vertical: height12, horizontal: width12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  mainAxisSpacing: height8,
                  crossAxisSpacing: height8,
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
      ),

      // child: FutureBuilder(
      //   future: Provider.of<ProductProvider>(context, listen: false)
      //       .searchProduct(_searchController.text),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //           child: LoadingAnimationWidget.staggeredDotsWave(
      //               color: primaryColor, size: width12 * 5));
      //     } else {
      //       if (snapshot.error != null) {
      //         return Container();
      //       } else {
      //         return Consumer<ProductProvider>(
      //           builder: (context, productProvider, _) {
      //             var products = productProvider.searchedProducts;
      //             return GridView.builder(
      //               padding: EdgeInsets.symmetric(
      //                   vertical: height8 + 2, horizontal: width8),
      //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                   crossAxisCount: _crossAxisCount,
      //                   mainAxisSpacing: height8,
      //                   crossAxisSpacing: width8,
      //                   childAspectRatio: _aspectRatio),
      //               itemCount: 20,
      //               itemBuilder: (context, index) {
      //                 return ItemProductGrid(
      //                     productId: products[index].id,
      //                     productName: products[index].name,
      //                     price: products[index].price,
      //                     imageUrl: products[index].galleries[0].imageUrl,
      //                     category: products[index].category.name);
      //               },
      //             );
      //           },
      //         );
      //       }
      //     }
      //   },
      // ),
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
            'assets/images/searching-error.png',
            width: font24 * 5,
          ),
          SizedBox(
            height: height12,
          ),
          Text(
            'No Result Found',
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
              'We could not find any products for your search.',
              textAlign: TextAlign.center,
              style: vietnam400.copyWith(
                fontSize: font12,
                color: gray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
