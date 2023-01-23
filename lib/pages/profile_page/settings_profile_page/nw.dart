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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              if (_croppedImage != null)
                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.blueGrey,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.memory(_croppedImage!))),
                ),
              Wrap(
                spacing: 16,
                children: [
                  ElevatedButton(
                    child: const Text('Pick image'),
                    onPressed: () async {
                      image = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (image != null) {
                        final imageBytes = await image!.readAsBytes();
                        setState(() {
                          _imageToCrop = imageBytes;
                        });
                      }
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Crop image'),
                    onPressed: () async {
                      final imageBytes = await Cropper.crop(
                        cropperKey: _cropperKey,
                      );

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
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 500,
                child: _imageToCrop != null
                    ? Cropper(
                        cropperKey: _cropperKey,
                        overlayType: _overlayType,
                        image: Image.memory(_imageToCrop!),
                        onScaleStart: (details) {
                          // todo: define started action.
                        },
                        onScaleUpdate: (details) {
                          // todo: define updated action.
                        },
                        onScaleEnd: (details) {
                          // todo: define ended action.
                        },
                      )
                    : const ColoredBox(color: Colors.grey),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
