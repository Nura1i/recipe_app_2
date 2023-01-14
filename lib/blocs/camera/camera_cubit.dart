import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/camera/camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInit());
  bool isOpen = false;

  File? image;
  Future pickImageFromGalery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on Exception catch (e) {
      log('Failed to pick image: $e');
    }
    emit(imagePick(image));
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on Exception catch (e) {
      log('Failed to pick image: $e');
    }
    emit(imagePick(image));
  }

  Future deletePhoto() async {
    emit(imagePick(null));
  }
}
