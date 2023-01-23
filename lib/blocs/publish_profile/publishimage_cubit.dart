import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/publish_profile/publish_state.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/nw.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

// Uint8List? _imageToCrop;
// Uint8List? _croppedImage;
// File? file;

class ImagePublishCubit extends Cubit<PublishImageState> {
  ImagePublishCubit() : super(ImageInit());
  // final ImagePicker _picker = ImagePicker();

  openCropper(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CropperScreenn(),
    ));
    // final imgg = await _picker.pickImage(source: ImageSource.gallery);
    // if (imgg != null) {
    //   //crop = true;
    //   final imageBytes = await imgg.readAsBytes();
    //   _imageToCrop = imageBytes;
    //   _croppedImage = imageBytes;
    //   emit(ImageInit(cropper: _imageToCrop));
    //   emit(CroppState(croop: _croppedImage));

    //   imgg != null
    //       ? Navigator.of(context).push(
    //           MaterialPageRoute(builder: (context) => const CropperScreen()))
    //       : const SizedBox();
    //   return null;
    // }
  }

  func(imagee) async {
    // imagee = await _picker.pickImage(source: ImageSource.gallery);
    if (imagee != null) {
      final imageBytes = await imagee!.readAsBytes();
      // _imageToCrop = imageBytes;
      // emit(ImageInit(cropper: _imageToCrop));
    }
  }

  bool? isEnabled = true;
  bool? isLoading = false;

  publish(XFile img) async {
    // XFile? image;
    bool? isEnabled = true;
    bool? isLoading = true;
    try {
      userModel usermodel11 =
          userModel(id: FirebaseAuth.instance.currentUser!.uid);
      File file = File(img.path);
      final isPublished = FireDatabaseService.updateProfile(
          usermodel: usermodel11, image: file);
      debugPrint('PUBLISHED');
      isLoading = false;
      debugPrint('PUBLISHED');
      // emit(ImageInit(cropper: img));
      emit(CroppState(croop: img));
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