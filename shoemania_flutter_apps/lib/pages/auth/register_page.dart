import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            SizedBox(
              height: height20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  formName(),
                  SizedBox(
                    height: height12,
                  ),
                  formEmail(),
                  SizedBox(
                    height: height12,
                  ),
                  formPhone(),
                  SizedBox(
                    height: height12,
                  ),
                  formPassword(),
                  SizedBox(
                    height: height12,
                  ),
                  formConfirmPassword(),
                  SizedBox(
                    height: height18,
                  ),
                  signupButton(),
                ],
              ),
            ),
            SizedBox(
              height: height16,
            ),
            textFooter(),
            SizedBox(
              height: height24,
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(vertical: width24, horizontal: width28),
      // color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign Up',
            style: publicsans600.copyWith(fontSize: font20, color: blackColor),
          ),
          SizedBox(
            height: height8,
          ),
          Text(
            'Create your account to start',
            style: vietnam500.copyWith(fontSize: font13, color: greyColor),
          ),
        ],
      ),
    );
  }

  Widget formName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Full Name',
          style: vietnam500.copyWith(
            fontSize: font13,
            color: blackColor,
          ),
        ),
        SizedBox(
          height: height8,
        ),
        TextFormField(
          controller: _name,
          validator: (value) {
            if (value!.isEmpty) {
              return "Name must not be empty!";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.name,
          style: vietnam400.copyWith(fontSize: font13),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: height16, horizontal: width12),
            filled: true,
            fillColor: white,
            hintText: 'Type your full name',
            hintStyle: vietnam400.copyWith(color: gray, fontSize: font13),
            prefixIcon: Icon(
              Icons.person_pin_circle_rounded,
              size: width24,
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

  Widget formPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Phone Number',
          style: vietnam500.copyWith(
            fontSize: font13,
            color: blackColor,
          ),
        ),
        SizedBox(
          height: height8,
        ),
        TextFormField(
          controller: _phoneNumber,
          validator: (value) {
            if (value!.isEmpty) {
              return "Phone number must not be empty!";
            } else if (value.length <= 10 || value.length >= 15) {
              return "Invalid phone number";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.number,
          style: vietnam400.copyWith(fontSize: font13),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: height16, horizontal: width12),
            filled: true,
            fillColor: white,
            hintText: 'Type your phone number',
            hintStyle: vietnam400.copyWith(color: gray, fontSize: font13),
            prefixIcon: Icon(
              Icons.phone_sharp,
              size: width24,
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
          controller: _email,
          validator: (value) {
            if (value!.isEmpty) {
              return "Email address must not be empty!";
            } else if (!value.contains("@") || !value.contains(".")) {
              return "Invalid email address!";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          style: vietnam400.copyWith(fontSize: font13),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: height16, horizontal: width12),
            filled: true,
            fillColor: white,
            hintText: 'Type your email address',
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
          controller: _password,
          validator: (value) {
            if (value!.isEmpty) {
              return "Password must not be empty!";
            } else if (Helpers.passwordValidate(value)) {
              return "Password must have at least 8 characters with number combination!";
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.streetAddress,
          style: vietnam400.copyWith(fontSize: font13),
          obscureText: _isObscure2,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: height16, horizontal: width12),
            filled: true,
            fillColor: white,
            hintText: 'Type your password',
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
                  _isObscure2 = !_isObscure2;
                });
              },
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

  Widget formConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Confirm Password',
          style: vietnam500.copyWith(
            fontSize: font13,
            color: blackColor,
          ),
        ),
        SizedBox(
          height: height8,
        ),
        TextFormField(
          controller: _confirmPassword,
          validator: (value) {
            if (value!.isEmpty) {
              return "Confirm your password!";
            } else if (value != _password.text) {
              return "Your Password does not match!";
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.streetAddress,
          style: vietnam400.copyWith(fontSize: font13),
          obscureText: _isObscure,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: height16, horizontal: width12),
            filled: true,
            fillColor: white,
            hintText: 'Type again your password',
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
        )
      ]),
    );
  }

  Widget signupButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          final code = await authProvider.register(
              _name.text, _phoneNumber.text, _email.text, _password.text);
          switch (code) {
            case 200:
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);

              break;
            case 444:
              showError(
                  context,
                  "This email address has been used by other user!",
                  "assets/images/bad-gateway.png");
              break;
            case 445:
              showError(
                  context,
                  "This phone number has been used by other user!",
                  "assets/images/bad-gateway.png");
              break;
            case 500:
              showError(context, "Something went wrong!",
                  "assets/images/bad-gateway.png");
              break;
            default:
              showError(context, "Something went wrong!",
                  "assets/images/bad-gateway");
              break;
          }
        }
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
            'Sign me up',
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
    //     onPressed: () async {},
    //     style: ElevatedButton.styleFrom(
    //         padding: EdgeInsets.symmetric(vertical: height20),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(width8 + 2),
    //         )),
    //     child: Text(
    //       'Sign Up',
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
      margin: EdgeInsets.only(top: height28),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have account? ',
              style: vietnam400.copyWith(
                fontSize: font14,
                color: greyColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: Text(
                'Sign In',
                style: vietnam500.copyWith(
                  fontSize: font14,
                  color: primaryColor,
                ),
              ),
            ),
          ]),
    );
  }

  showError(BuildContext context, String message, String imagePath) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: width32 * 5,
              height: height40 * 5,
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
