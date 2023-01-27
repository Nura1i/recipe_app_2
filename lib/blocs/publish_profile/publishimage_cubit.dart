import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/blocs/publish_profile/publish_state.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';

import 'package:recipe_app/pages/profile_page/settings_profile_page/croppPage.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

Uint8List? imageToCrop;
Uint8List? croppedImage;
Uint8List? imageBytes;
ImagePicker? _picker = ImagePicker();

XFile? imagee;

class ImagePublishCubit extends Cubit<PublishImageState> {
  ImagePublishCubit() : super(ImageInit());

  openCropper(BuildContext context, XFile? imgg) async {
    imgg = await _picker!.pickImage(source: ImageSource.gallery);
    if (imgg != null) {
      //crop = true;
      imageBytes = await imgg.readAsBytes();
      imageToCrop = imageBytes;
      emit(ImageInit(cropper: imageToCrop));

      imgg != null
          ? Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CropperScreenn()))
          : const SizedBox();
      return null;
    }
  }

  func(emagee) async {
    imagee == _picker!.pickImage(source: ImageSource.gallery);
    if (imagee != null) {
      final imageBytes = await imagee!.readAsBytes();
      imageToCrop = imageBytes;
    }
  }

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
      // emit(CroppState(croop: img));
      // setState(() {});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
