import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/pages/auth/login_page.dart';
import 'package:shoemania/pages/auth/register_page.dart';
import 'package:shoemania/pages/carts/cart_page.dart';
import 'package:shoemania/pages/main_page.dart';
import 'package:shoemania/pages/orders/order_failed.dart';
import 'package:shoemania/pages/orders/order_page.dart';
import 'package:shoemania/pages/orders/select_address.dart';
import 'package:shoemania/pages/products/all_product_page.dart';
import 'package:shoemania/pages/profile/add_new_address.dart';
import 'package:shoemania/pages/profile/address_page.dart';
import 'package:shoemania/pages/profile/edit_profile.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/cart_provider.dart';
import 'package:shoemania/providers/order_provider.dart';
import 'package:shoemania/providers/product_provider.dart';
import 'package:shoemania/themes/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Provider.of<AuthProvider>(context, listen:  false).getUserData();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'BeVietnam',
          visualDensity: VisualDensity.comfortable,
          colorScheme: ThemeData().colorScheme.copyWith(
                onPrimary: white,
                primary: primaryColor,
                secondary: primaryColor,
                onSecondary: white,
              ),
          inputDecorationTheme: InputDecorationTheme(),
        ),
        home: const MainPage(),
        routes: {
          // '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const MainPage(),
          '/myorder': (context) => const OrderPage(),
          '/allproduct': (context) => const AllProductPage(),
          '/cart': (context) => const CartPage(),
          '/edit-profile': (context) => const EditProfile(),
          '/address': (context) => const AddressPage(),
          '/new-address': (context) => const AddNewAddressPage(),
          '/select-address': (context) => const SelectAddressPage(),
          '/order-failed': (context) => const OrderFailedPage(),
        },
      ),
    );
  }
}
