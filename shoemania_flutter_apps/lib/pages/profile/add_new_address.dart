import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/models/address_model.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';
import 'package:shoemania/utils/helpers.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "";

  TextEditingController _name = TextEditingController();

  TextEditingController _address = TextEditingController();

  TextEditingController _postalCode = TextEditingController();

  TextEditingController _phone = TextEditingController();

  bool isLoading = false;

  Address? address;

  // Toast Success
  Widget successToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Successfully add new address",
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
      "Failed to add new address!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  // @override
  // void initState() {
  //   super.initState();
  //   getAddress();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          header(),
          Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Form(
                      key: _formKey,
                      child: ListView(children: [
                        SizedBox(
                          height: height16,
                        ),
                        formName(),
                        formPhone(),
                        formAddress(),
                        formPostalCode(),
                        SizedBox(height: height20),
                        buttonSubmit(),
                      ]),
                    ))
        ],
      )),
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
            'Add New Address',
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

  Widget formName() {
    return Container(
      margin: EdgeInsets.fromLTRB(width28, height8, width28, height12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name",
              style:
                  vietnam500.copyWith(fontSize: font14, color: primaryColor)),
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
              if (Helpers.nameValidate(value!)) {
                return 'Type your name correctly!';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: height4),
              hintText: "Type your full name",
              hintStyle: vietnam400.copyWith(color: gray),
            ),
          )
        ],
      ),
    );
  }

  Widget formAddress() {
    return Container(
      margin: EdgeInsets.fromLTRB(width28, height8, width28, height12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Address",
              style:
                  vietnam500.copyWith(fontSize: font14, color: primaryColor)),
          TextFormField(
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            controller: _address,
            // initialValue: email,
            keyboardType: TextInputType.emailAddress,
            style: vietnam400.copyWith(fontSize: font13),
            validator: (value) {
              if (value!.isEmpty) {
                return "Address must not be empty!";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: height4),
              hintText: "Type your complete address",
              hintStyle: vietnam400.copyWith(color: gray),
            ),
          )
        ],
      ),
    );
  }

  Widget formPhone() {
    return Container(
      margin: EdgeInsets.fromLTRB(width28, height8, width28, height12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone Number",
              style:
                  vietnam500.copyWith(fontSize: font14, color: primaryColor)),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _phone,
            // initialValue: phone,
            keyboardType: TextInputType.number,
            style: vietnam400.copyWith(fontSize: font13),
            validator: (value) {
              if (value!.isEmpty) {
                return "Phone number must not be empty!";
              } else if (Helpers.phoneValidate(value)) {
                return "Invalid phone number!";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: height4),
              hintText: "Type your phone number",
              hintStyle: vietnam400.copyWith(color: gray),
            ),
          )
        ],
      ),
    );
  }

  Widget formPostalCode() {
    return Container(
      margin: EdgeInsets.fromLTRB(width28, height8, width28, height12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Postal Code",
              style:
                  vietnam500.copyWith(fontSize: font14, color: primaryColor)),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: _postalCode,
            // initialValue: phone,
            keyboardType: TextInputType.number,
            style: vietnam400.copyWith(fontSize: font13),
            validator: (value) {
              if (value!.isEmpty) {
                return "Postal code must not be empty!";
              } else if (Helpers.postalCodeValidate(value)) {
                return "Invalid postal code!";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: height4),
              hintText: "Type your postal code",
              hintStyle: vietnam400.copyWith(color: gray),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonSubmit() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          FToast().init(context);
          showLoading();
          var result = await Provider.of<AuthProvider>(context, listen: false)
              .addAddress(
                  _name.text, _phone.text, _address.text, _postalCode.text);
          Navigator.pop(context);
          if (result) {
            Navigator.pop(context);
          } else {
            FToast().showToast(child: errorToast, gravity: ToastGravity.CENTER);
          }
        }
      },
      child: Container(
        width: screenWidth,
        height: height40 * 1.4,
        margin: EdgeInsets.symmetric(horizontal: width24),
        padding:
            EdgeInsets.symmetric(horizontal: width20, vertical: height12 - 2),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(width12)),
        child: Center(
          child: Text(
            'Save Address',
            style: vietnam500.copyWith(fontSize: font14, color: white),
          ),
        ),
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
                  color: primaryColor, size: width12 * 5),
            )));
  }
}
