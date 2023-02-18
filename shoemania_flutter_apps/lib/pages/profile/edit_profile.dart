import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/user_model.dart';
import 'package:shoemania/pages/profile/edit_photo_profile.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "";

  TextEditingController _name = TextEditingController();

  TextEditingController _email = TextEditingController();

  TextEditingController _phone = TextEditingController();

  bool isLoading = true;

  // Toast Success
  Widget successToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Successfully update profile",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  // Toast Error
  Widget errorEmailUsed = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Email address has already been taken!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );
  // Toast Error
  Widget errorPhoneUsed = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Phone number has already been taken!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );
  // Toast Error
  Widget errorToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Failed to update your profile!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async {
    final user = await Provider.of<AuthProvider>(context, listen: false).user;
    _name.text = user.name;
    _email.text = user.email;
    _phone.text = user.phoneNumber;
    imageUrl = user.profilePhotoUrl;
    setState(() {
      isLoading = false;
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   var user = Provider.of<AuthProvider>(context).user;
  //   _name.text = user.name;
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User user = authProvider.user;

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(children: [
                          profilePhoto(),
                          formName(),
                          formEmail(),
                          formPhone()
                        ]),
                      ),
                    )
            ],
          ),
        ));
  }

  Widget content(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(),
      ),
    );
  }

  Widget profilePhoto() {
    return Column(
      children: [
        SizedBox(
          height: height24,
        ),
        Container(
          width: width32 * 4,
          height: width32 * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            color: silver,
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: height12,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UpdatePhotoProfile()));
          },
          child: Text(
            "Change Photo",
            style: vietnam400.copyWith(fontSize: font13, color: blackColor),
          ),
        ),
        SizedBox(
          height: height8,
        ),
      ],
    );
  }

  Widget formName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28, vertical: height8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name",
              style:
                  vietnam500.copyWith(fontSize: font15, color: primaryColor)),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _name,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            style: vietnam400.copyWith(fontSize: font13),
            validator: (value) {
              if (_name.text.isEmpty) {
                return "Name must not be empty!";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Type your full name",
              hintStyle: vietnam400.copyWith(color: gray),
            ),
          )
        ],
      ),
    );
  }

  Widget formEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28, vertical: height8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email Address",
              style:
                  vietnam500.copyWith(fontSize: font15, color: primaryColor)),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _email,
            // initialValue: email,
            keyboardType: TextInputType.emailAddress,
            style: vietnam400.copyWith(fontSize: font13),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Alamat email tidak boleh kosong!';
              }
              if (Helpers.emailValidate(value) == false) {
                return 'Masukkan email yang valid!';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Type your email address",
              hintStyle: vietnam400.copyWith(color: gray),
            ),
          )
        ],
      ),
    );
  }

  Widget formPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width28, vertical: height8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone Number",
              style:
                  vietnam500.copyWith(fontSize: font15, color: primaryColor)),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: _phone,
            // initialValue: phone,
            keyboardType: TextInputType.number,
            style: vietnam400.copyWith(fontSize: font13),
            validator: (value) {
              if (value!.isEmpty) {
                return "Phone number must not be empty!";
              } else if (value.length <= 10 || value.length >= 15) {
                return "Invalid phone number!";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Type your phone number",
              hintStyle: vietnam400.copyWith(color: gray),
            ),
          )
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
              icon: Icon(Icons.close_rounded)),
          Text(
            'Edit Profile',
            style: publicsans600.copyWith(fontSize: font16, color: blackColor),
          ),
          IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                FToast().init(context);
                showLoading();
                var result =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .updateUser(_name.text, _email.text, _phone.text);
                Navigator.pop(context);
                switch (result) {
                  case 200:
                    Navigator.pop(context);

                    break;
                  case 480:
                    FToast().showToast(
                        child: errorEmailUsed, gravity: ToastGravity.CENTER);

                    break;
                  case 450:
                    FToast().showToast(
                        child: errorPhoneUsed, gravity: ToastGravity.CENTER);

                    break;
                  case 500:
                    FToast().showToast(
                        child: errorToast, gravity: ToastGravity.CENTER);

                    break;
                  default:
                    FToast().showToast(
                        child: errorToast, gravity: ToastGravity.CENTER);
                }
              }
            },
            icon: Icon(Icons.check_outlined),
          ),
        ],
      ),
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
                borderRadius: BorderRadius.circular(width12),
                color: white,
              ),
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: primaryColor, size: width8 * 5),
            )));
  }
}
