import 'dart:developer';
import 'dart:io';
import 'package:cropperx/cropperx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

class CropperScreenn extends StatefulWidget {
  const CropperScreenn({Key? key});

  @override
  State<CropperScreenn> createState() => _CropperScreennState();
}

class _CropperScreennState extends State<CropperScreenn> {
  @override
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _cropperKey = GlobalKey(debugLabel: 'cropperKey');
  Uint8List? _imageToCrop;
  Uint8List? _croppedImage;
  final OverlayType _overlayType = OverlayType.circle;

  @override
  Widget build(BuildContext context) {
    XFile? image;
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 500,
                  child: _imageToCrop != null
                      ? Cropper(
                          cropperKey: _cropperKey,
                          overlayType: _overlayType,
                          image: Image.memory(_imageToCrop!),
                          onScaleStart: (details) {},
                          onScaleUpdate: (details) {},
                          onScaleEnd: (details) {},
                        )
                      : const Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 100,
                            color: Colors.black,
                          ),
                        )),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 26, 4, 4),
                    child: const Text(
                      'Galery images',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      image = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 50);

                      if (image != null) {
                        final imageBytes = await image!.readAsBytes();
                        setState(() {
                          _imageToCrop = imageBytes;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    color: Colors.black,
                    child: const Icon(Icons.crop, color: Colors.white),
                    onPressed: () async {
                      final imageBytes =
                          await Cropper.crop(cropperKey: _cropperKey);

                      if (imageBytes != null) {
                        _croppedImage = imageBytes;
                        userModel usermodel11 = userModel(
                            id: FirebaseAuth.instance.currentUser!.uid);
                        Directory tempDir = await getTemporaryDirectory();
                        File file =
                            await File('${tempDir.path}/image.png').create();
                        file.writeAsBytesSync(_croppedImage!);
                        FireDatabaseService.updateProfile(
                            usermodel: usermodel11, image: file);
                        log('PUBLISHED');
                        setState(() {});
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
