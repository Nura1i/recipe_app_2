import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/camera/camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInit());
  bool isOpen = false;

  void openCamera() async {
    ImagePicker.platform.getImageFromSource(
      source: ImageSource.camera,
    );
    emit(CameraOpen(isOpen));
  }

  void openGalerea() async {
    isOpen = !isOpen;
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    isOpen = !isOpen;
    emit(Galere(isOpen));
  }
}
