import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/publish_profile/publish_state.dart';
import 'package:recipe_app/models/user_model.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/image_cropper.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

Uint8List? _imageToCrop;
Uint8List? _croppedImage;
File? file;
XFile? imagee;

class ImagePublishCubit extends Cubit<PublishImageState> {
  ImagePublishCubit() : super(ImageInit());
  final ImagePicker _picker = ImagePicker();

  openCropper(BuildContext context, imgg) async {
    imgg = await _picker.pickImage(source: ImageSource.gallery);
    if (imgg != null) {
      //crop = true;
      final imageBytes = await imgg!.readAsBytes();
      _imageToCrop = imageBytes;
      emit(ImageInit(cropper: _imageToCrop));

      imgg != null
          ? Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CropperScren(
                    img: imgg,
                  )))
          : const SizedBox();
      return null;
    }
  }

  func(imagee) async {
    imagee = await _picker.pickImage(source: ImageSource.gallery);
    if (imagee != null) {
      final imageBytes = await imagee!.readAsBytes();
      _imageToCrop = imageBytes;
      emit(ImageInit(cropper: _imageToCrop));
    }
  }
  bool? isEnabled = true;
  bool? isLoading = false;
  publish() {
    bool? isEnabled = true;
    bool? isLoading = true;
    try {
      userModel usermodel11 =
          userModel(id: FirebaseAuth.instance.currentUser!.uid);
      File file = File(imagee!.path);
      final isPublished =
          FireDatabaseService.createPost(usermodel: usermodel11, image: file);
      if (isPublished != null) {
        debugPrint('PUBLISHED');
        isLoading = false;
        // Blocga Otqazish uchun
        // setState(() {});

      }
      debugPrint('PUBLISHED');
      // setState(() {});
    } catch (e) {
      log(e.toString());
      return null;
    }

    // void initState() {
    //   func();
    // }

    // void func() async {
    //   if (image != null) {
    //     final imageBytes = await image!.readAsBytes();

    //     // setState(() {
    //     //   _imageToCrop = imageBytes;
    //     // });
    //   }
    // }

// bool? isEnabled = true;
//   bool? isLoading = false;
//   void publish() async {
//     isEnabled = true;
//     isLoading = true;

//     try {
//       userModel usermodel11 = userModel(
//         id: FirebaseAuth.instance.currentUser!.uid,
//       );
//       file = File(image!.path);
//       final isPublished = await FireDatabaseService.createPost(
//           usermodel: usermodel11, image: file);

//       if (isPublished != null) {
//         debugPrint('PUBLISHED');
//         isLoading = false;

//  // Blocga Otqazish uchun

//        // setState(() {});

//       }
//       debugPrint('PUBLISHED');
//       // setState(() {});
//     } catch (e) {
//       log(e.toString());
//     }
//   }
  }
}
