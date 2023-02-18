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
  final image;
  const CropperScreenn({Key? key, this.image});

  @override
  State<CropperScreenn> createState() => _CropperScreennState();
}

class _CropperScreennState extends State<CropperScreenn> {
  @override
  void initState() {
    updateData();
    super.initState();
    setState(() {});
  }

  @override
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _cropperKey = GlobalKey(debugLabel: 'cropperKey');
  Uint8List? _imageToCrop;
  Uint8List? _croppedImage;
  final OverlayType _overlayType = OverlayType.circle;

  updateData() async {
    if (widget.image != null) {
      final imageBytes = await widget.image!.readAsBytes();
      setState(() {
        _imageToCrop = imageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            child: const Icon(Icons.check_circle_outline,
                size: 33, color: Colors.blue),
            onPressed: () async {
              final imageBytes = await Cropper.crop(cropperKey: _cropperKey);

              if (imageBytes != null) {
                _croppedImage = imageBytes;
                userModel usermodel11 =
                    userModel(id: FirebaseAuth.instance.currentUser!.uid);
                Directory tempDir = await getTemporaryDirectory();
                File file = await File('${tempDir.path}/image.png').create();
                file.writeAsBytesSync(_croppedImage!);
                FireDatabaseService.updateProfile(
                    usermodel: usermodel11, image: file);
                log('PUBLISHED');
                setState(() {});
              }
              Navigator.of(context).pop();
            },
          )
        ],
        title: const Text(
          'Change photo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: .0,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 500,
                  child: _imageToCrop != null
                      ? Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 3, color: Colors.orange)),
                          child: Cropper(
                            cropperKey: _cropperKey,
                            overlayType: _overlayType,
                            image: Image.memory(_imageToCrop!),
                            onScaleStart: (details) {},
                            onScaleUpdate: (details) {},
                            onScaleEnd: (details) {},
                          ),
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
                children: const [
                  SizedBox(
                    width: 20,
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
