import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/croppPage.dart';

void displayBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    elevation: 10,
    backgroundColor: Theme.of(context).backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(40).r,
        topRight: const Radius.circular(40).r,
      ),
    ),
    builder: (ctx) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.10,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Camera...!
              IconButton(
                highlightColor: Colors.white,
                iconSize: 40,
                onPressed: () {
                  BlocProvider.of<CameraCubit>(context)
                      .pickImageFromCamera(context);
                },
                icon: SvgPicture.asset(
                  'assets/svg/camera.svg',
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              // Icon  Galalery...!
              IconButton(
                iconSize: 40,
                highlightColor: Colors.white,
                onPressed: () {
                  BlocProvider.of<CameraCubit>(context)
                      .pickImageFromGalery(context);
                },
                icon: SvgPicture.asset(
                  'assets/svg/gallery.svg',
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void displayBottomSheetForProfile(BuildContext context) {
  final ImagePicker picker = ImagePicker();
  XFile image;
  showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      builder: (ctx) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        image = (await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 50))!;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return CropperScreenn(
                              image: image,
                            );
                          },
                        ));
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/camera.svg',
                        width: 45,
                      )),
                  const SizedBox(
                    width: 100,
                  ),
                  IconButton(
                      iconSize: 45,
                      onPressed: () async {
                        image = (await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 50))!;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return CropperScreenn(
                              image: image,
                            );
                          },
                        ));
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/gallery.svg',
                      )),
                ],
              ),
            ));
      });
}
