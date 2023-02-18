import 'package:custom_top_navigator/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoemania/pages/chats/chat_page.dart';
import 'package:shoemania/pages/home/home_page.dart';
import 'package:shoemania/pages/profile/profile_page.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    ProfilePage(),
  ];

  void onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget bodyPage() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
        break;
      case 1:
        return ProfilePage();
        break;
      default:
        return HomePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        }
        setState(() {
          _currentIndex = 0;
        });
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        child: Scaffold(
          body: _pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: white,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: vietnam400.copyWith(fontSize: font10 + 1),
              unselectedLabelStyle: vietnam400.copyWith(fontSize: font10 + 1),
              selectedItemColor: primaryColor,
              unselectedItemColor: gray,
              currentIndex: _currentIndex,
              onTap: onTap,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(width8),
                      child: Icon(FontAwesomeIcons.house),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(width8),
                      child: Icon(_currentIndex == 1
                          ? BootstrapIcons.chat_dots_fill
                          : BootstrapIcons.chat_dots),
                    ),
                    label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(width8),
                      child: Icon(_currentIndex == 2
                          ? BootstrapIcons.person_fill
                          : BootstrapIcons.person),
                    ),
                    label: 'Profile'),
              ]),
        ),
      ),
    );
  }
}

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int _currentIndex = 0;

  void onTap(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        HomePage(),
        ProfilePage(),
      ],
      onItemTap: onTap,
      scaffold: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: secondaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: vietnam300.copyWith(fontSize: font10),
            unselectedLabelStyle: vietnam300.copyWith(fontSize: font10),
            selectedItemColor: primaryColor,
            unselectedItemColor: gray,
            currentIndex: _currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(width8),
                    child: Icon(FontAwesomeIcons.house),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(width8),
                    child: Icon(_currentIndex == 1
                        ? BootstrapIcons.chat_dots_fill
                        : BootstrapIcons.chat_dots),
                  ),
                  label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(width8),
                    child: Icon(_currentIndex == 3
                        ? FontAwesomeIcons.solidUser
                        : FontAwesomeIcons.user),
                  ),
                  label: 'Profile'),
            ]),
      ),
    );
  }
}

class CustomHomePage extends StatefulWidget {
  CustomHomePage({Key? key}) : super(key: key);

  @override
  _CustomHomePageState createState() => _CustomHomePageState();
}

class _CustomHomePageState extends State<CustomHomePage> {
  final List<Widget> _children = [HomePage(), ProfilePage()];
  Widget _page = HomePage();
  int _currentIndex = 0;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: _items,
  //       onTap: (index) {

  //         navigatorKey.currentState.maybePop();
  //         setState(() => _page = _children[index]);
  //         _currentIndex = index;
  //       },
  //       currentIndex: _currentIndex,
  //     ),
  //     body: CustomNavigator(
  //       navigatorKey: navigatorKey,
  //       home: _page,
  //       pageRoute: PageRoutes.materialPageRoute,
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      scaffold: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.looks_one),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.looks_two),
              label: 'Profile',
            ),
          ],
        ),
      ),
      children: <Widget>[HomePage(), ProfilePage()],
      onItemTap: (index) {},
    );
  }
}
