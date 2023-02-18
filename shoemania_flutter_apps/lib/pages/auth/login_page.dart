import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            header(),
            SizedBox(
              height: height32,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  formEmail(),
                  SizedBox(
                    height: height20,
                  ),
                  formPassword(),
                  SizedBox(
                    height: height28,
                  ),
                  signinButton(context),
                ],
              ),
            ),
            Spacer(),
            textFooter(),
          ],
        )),
      ),
    );
  }

  Widget header() {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(vertical: width20, horizontal: width28),
      // color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: publicsans600.copyWith(fontSize: font20, color: blackColor),
          ),
          SizedBox(
            height: height8,
          ),
          Text(
            'Sign In to Continue',
            style: vietnam500.copyWith(fontSize: font13, color: greyColor),
          ),
        ],
      ),
    );
  }

  Widget formEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Email Address',
          style: vietnam500.copyWith(
            fontSize: font13,
            color: blackColor,
          ),
        ),
        SizedBox(
          height: height8,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          controller: _email,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email address must not be empty!';
            }
            if (Helpers.emailValidate(value) == false) {
              return 'Invalid email address!';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          style: vietnam400.copyWith(fontSize: font13),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: height16 + 1, horizontal: width12),
            filled: true,
            fillColor: white,
            hintText: 'Masukkan email anda',
            hintStyle: vietnam400.copyWith(color: gray, fontSize: font13),
            prefixIcon: Icon(
              Icons.email_rounded,
              size: width20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width12),
              borderSide: BorderSide(color: gray, width: 1.5),
            ),
          ),
        )
      ]),
    );
  }

  Widget formPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Password',
          style: vietnam500.copyWith(
            fontSize: font13,
            color: blackColor,
          ),
        ),
        SizedBox(
          height: height8,
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          controller: _password,
          validator: (value) {
            if (_password.text.isEmpty) {
              return "Password must not be empty!";
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
          style: vietnam400.copyWith(fontSize: font13),
          obscureText: _isObscure,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: height16 + 1, horizontal: width12),
            filled: true,
            fillColor: white,
            hintText: 'Masukkan kata sandi',
            hintStyle: vietnam400.copyWith(color: gray, fontSize: font13),
            prefixIcon: Icon(
              Icons.lock_rounded,
              size: width24,
            ),
            suffixIcon: IconButton(
              icon: Icon(_isObscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width12),
              borderSide: BorderSide(color: gray, width: 1.5),
            ),
          ),
          onFieldSubmitted: (value) {
            if (_formKey.currentState!.validate()) {
              login(context);
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(_email.text + " | " + _password.text),
              // ));
            }
          },
        )
      ]),
    );
  }

  Widget signinButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        login(context);
      },
      child: Container(
        width: screenWidth,
        margin: EdgeInsets.symmetric(horizontal: width28),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(width12),
        ),
        padding: EdgeInsets.symmetric(
          vertical: height16,
        ),
        child: Center(
          child: Text(
            'Log me in',
            style: vietnam500.copyWith(fontSize: font14, color: white),
          ),
        ),
      ),
    );
    // return Container(
    //   width: screenWidth,
    //   margin: EdgeInsets.symmetric(horizontal: width28),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: ElevatedButton(
    //     onPressed: () {
    //       login(context);
    //     },
    //     style: ElevatedButton.styleFrom(
    //         padding: EdgeInsets.symmetric(vertical: height20),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(width8 + 2),
    //         )),
    //     child: Text(
    //       'Sign In',
    //       style: vietnam500.copyWith(
    //         fontSize: font16,
    //         color: white,
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget textFooter() {
    return Container(
      margin: EdgeInsets.only(bottom: height28),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum mempunyai akun? ',
              style: vietnam400.copyWith(
                fontSize: font14,
                color: greyColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Sign Up',
                style: vietnam500.copyWith(
                  fontSize: font14,
                  color: primaryColor,
                ),
              ),
            ),
          ]),
    );
  }

  login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      showLoading();
      final code = await authProvider.login(_email.text, _password.text);
      print(code.toString());
      Navigator.pop(context);
      if (code == 200) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else if (code == 403) {
        showError(
            context, "Incorrect password", "assets/images/bad-gateway.png");
      } else if (code == 404) {
        showError(context, "This email address is not registered yet",
            "assets/images/page-lost.png");
      } else if (code == 500) {
        showError(
            context, "Something went wrong!", "assets/images/went-wrong.png");
      }

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(_email.text + " | " + _password.text),
      //   duration: Duration(milliseconds: 1200),
      // ));
    }
  }

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
                padding: EdgeInsets.symmetric(
                    horizontal: width20, vertical: height16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width16),
                  color: white,
                ),
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: primaryColor, size: width12 * 5),
              ),
            ));
  }

  showError(BuildContext context, String message, String imagePath) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: width32 * 5,
              height: height40 * 5,
              // padding:
              //     EdgeInsets.symmetric(vertical: height8, horizontal: width12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width12),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      imagePath,
                      height: height40 * 2.2,
                    ),
                    SizedBox(
                      height: height6,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: vietnam400.copyWith(
                          fontSize: font15, color: blackColor),
                    ),
                    SizedBox(
                      height: height12,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: height16),
                            minimumSize: Size(double.maxFinite, height24 * 1.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(width8))),
                        child: Text("OK",
                            style: vietnam500.copyWith(
                                fontSize: font15, color: white)))
                  ]),
            ),
          );
        });
  }
}
