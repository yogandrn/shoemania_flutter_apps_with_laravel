import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoemania/models/message_model.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/providers/message_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/widgets/item_chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAuth = false;
  int? _userId;
  bool isLoading = true;

  Future<void> _onRefresh() async {
    await MessageService().getMessages();
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
    _userId = preferences.getInt("user_id") ?? 0;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  content(),
                ],
              ),
      ),
    );
  }

  Widget loading() {
    return Expanded(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }

  Widget header() {
    return Container(
      color: primaryColor,
      height: height40 * 1.5,
      padding: EdgeInsets.symmetric(horizontal: width12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Chat Message',
            style: publicsans600.copyWith(fontSize: font15, color: white),
          ),
        ],
      ),
    );
  }

  Widget content() {
    // return FutureBuilder<List<MessageModel>>(
    //     future: MessageService().getMessages(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Expanded(
    //             child: Column(
    //           children: [Text('Something Went Wrong!')],
    //         ));
    //       }
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.data!.isEmpty) {
    //           return empty();
    //         }

    //         return Expanded(
    //           child: ListView.builder(
    //               padding: EdgeInsets.symmetric(
    //                   vertical: height8, horizontal: width8),
    //               itemCount: 1,
    //               itemBuilder: (context, index) {
    //                 return ItemChatTile(
    //                   message: snapshot.data![snapshot.data!.length - 1],
    //                 );
    //               }),
    //         );
    //       }
    //       return loading();
    //     });
    if (_isAuth == false) {
      return Expanded(
        child: Column(
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
                'Please login to start messaging',
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
                Navigator.pushNamed(context, "/login");
              },
              child: Container(
                width: screenWidth / 2.2,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(width8)),
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
                Navigator.pushNamed(context, "/register");
              },
              child: Container(
                width: screenWidth / 2.2,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: primaryColor, width: 1.2),
                    borderRadius: BorderRadius.circular(width8)),
                padding: EdgeInsets.symmetric(vertical: height12),
                child: Center(
                  child: Text(
                    'Register',
                    style: vietnam400.copyWith(
                        fontSize: font13, color: primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return StreamBuilder<List<MessageModel>>(
      stream: MessageService().getMessageByUserId(
        // userId: Provider.of<AuthProvider>(context, listen: false).user.id,
        userId: _userId!,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return empty();
          } else {
            return Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      vertical: height8, horizontal: width8),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ItemChatTile(
                      message: snapshot.data![snapshot.data!.length - 1],
                    );
                  }),
            );
          }
        } else {
          return empty();
        }

        return Expanded(
          child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: primaryColor, size: width12 * 5)),
        );
      },
    );
  }

  Widget empty() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty-chat.png',
            width: font24 * 6,
          ),
          SizedBox(
            height: height12,
          ),
          Text(
            'Oops, no message yet',
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
              'You have not made any transactions yet',
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
                  Navigator.pushNamed(context, '/allproduct');
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
