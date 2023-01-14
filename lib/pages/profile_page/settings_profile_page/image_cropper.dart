import 'package:cropperx/cropperx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/publish_profile/publish_state.dart';
import 'package:recipe_app/blocs/publish_profile/publishimage_cubit.dart';

bool? isEnabled = true;
bool? isLoading = false;

class CropperScren extends StatelessWidget {
  final img;
  const CropperScren({super.key, this.img});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final GlobalKey cropperKey = GlobalKey(debugLabel: 'cropperKey');
    const OverlayType overlayType = OverlayType.circle;
    const int rotationTurns = 0;
    return Scaffold(
      body: BlocBuilder<ImagePublishCubit, PublishImageState>(
        builder: (context, state) {
          var crop;
          var truee;
          if (state is ImageInit) {
            crop = state.cropper;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 500,
                      child: crop != null
                          ? Cropper(
                              cropperKey: cropperKey,
                              overlayType: overlayType,
                              rotationTurns: rotationTurns,
                              image: Image.memory(crop!),
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
                    Wrap(
                      spacing: 16,
                      children: [
                        ElevatedButton(
                          child: const Text('Pick image'),
                          onPressed: () async {
                            BlocProvider.of<ImagePublishCubit>(context)
                                .func(img);
                          },
                        ),
                        ElevatedButton(
                          child: isLoading!
                              ? const CupertinoActivityIndicator()
                              : const Text('publish'),
                          onPressed: () async {
                            final imageBytes = await Cropper.crop(
                              cropperKey: cropperKey,
                            );
                            BlocProvider.of<ImagePublishCubit>(context).publish();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }
          return truee;
        },
      ),
    );
  }
}
