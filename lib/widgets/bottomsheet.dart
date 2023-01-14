import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/blocs/add_cubits/add_cubit.dart';

void displayBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      builder: (ctx) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.10,
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      //  iconSize: 40,
                      onPressed: () {
                        //  BlocProvider.of<CameraCubit>(context).openCamera();
                        BlocProvider.of<CameraCubit>(context)
                            .pickImageFromCamera(context);
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/camera.svg',
                        width: 45,
                      )

                      // const Icon(
                      //   Icons.camera_alt_outlined,
                      //   color: Colors.black,
                      //   size: 45,
                      // )),
                      ),
                  const SizedBox(
                    width: 100,
                  ),
                  IconButton(
                      iconSize: 45,
                      onPressed: () {
                        BlocProvider.of<CameraCubit>(context)
                            .pickImageFromGalery(context);
                        //    BlocProvider.of<CameraCubit>(context).openGalerea();
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/gallery.svg',
                      )),
                  // SizedBox(
                  //     child: img != null
                  //         ? Image.file(img)
                  //         : Text('    No Photo'))
                ],
              ),
            ));
      });
}
