import 'dart:io';

abstract class CameraState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CameraInit extends CameraState {}

class CameraOpen extends CameraState {
  final cameraOpen;
  CameraOpen(this.cameraOpen);
}

class imagePick extends CameraState {
  final imagepick;
  imagePick(this.imagepick);
}
