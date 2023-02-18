import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shoemania/providers/auth_provider.dart';
import 'package:shoemania/themes/colors.dart';
import 'package:shoemania/themes/fontstyle.dart';
import 'package:shoemania/themes/size.dart';

class UpdatePhotoProfile extends StatefulWidget {
  UpdatePhotoProfile({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  String? imageUrl;

  @override
  State<UpdatePhotoProfile> createState() => _UpdatePhotoProfileState();
}

class _UpdatePhotoProfileState extends State<UpdatePhotoProfile> {
  PickedFile? imageFile;
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";

  // Toast Success
  Widget successToast = Container(
    padding: EdgeInsets.symmetric(horizontal: width24, vertical: height16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width16),
        color: Colors.black.withOpacity(0.75)),
    child: Text(
      "Successfully update profile photo",
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
      "Failed to update profile photo!",
      style: vietnam400.copyWith(fontSize: font12, color: white),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(),
            // imagePreview(),
            Expanded(
              child: FutureBuilder<void>(
                  future: retriveLostData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Text('Picked your image');
                      case ConnectionState.done:
                        return imagePreview();
                      default:
                        return const Text('Picked an image');
                    }
                  }),
            )
          ],
        ),
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
            'Change Photo Profile',
            style: publicsans600.copyWith(fontSize: font16, color: blackColor),
          ),
          IconButton(
            onPressed: () async {
              FToast().init(context);
              showLoading();
              final result =
                  await Provider.of<AuthProvider>(context, listen: false)
                      .updatePhotoProfile(imageFile!.path);
              if (result == 200) {
                Navigator.pop(context);
                Navigator.pop(context);
                FToast().showToast(
                    child: successToast, gravity: ToastGravity.CENTER);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                FToast()
                    .showToast(child: errorToast, gravity: ToastGravity.CENTER);
              }
            },
            icon: Icon(Icons.check_outlined),
          ),
        ],
      ),
    );
  }

  Widget imagePreview() {
    if (imageFile != null) {
      return Column(children: [
        SizedBox(
          height: height40 * 2,
        ),
        Container(
          width: screenWidth / 1.75,
          height: screenWidth / 1.75,
          decoration: BoxDecoration(
            color: silver,
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.circular(width32 * 5),
            image: DecorationImage(
              image: FileImage(File(imageFile!.path)),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: width24 * 1.2,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: white,
                    size: font24,
                  ),
                ),
              )
            ],
          ),
        ),
      ]);
    } else {
      return Consumer<AuthProvider>(builder: (context, authProvider, _) {
        return Column(children: [
          SizedBox(
            height: height40 * 2,
          ),
          Container(
            width: screenWidth / 1.75,
            height: screenWidth / 1.75,
            decoration: BoxDecoration(
              color: silver,
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(width32 * 5),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    authProvider.user.profilePhotoUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: width24 * 1.2,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: white,
                      size: font24,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]);
      });
    }
  }

  Future<void> retriveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        imageFile = response.file;
      });
    } else {
      // print('Retrieve error ' + response.exception.code);
      Fluttertoast.showToast(msg: 'Something went wrong!');

      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(response.exception.code)));
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        imageFile = pickedFile;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Gagal memilih gambar\n" + e.toString());
    }
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
            )));
  }
}
