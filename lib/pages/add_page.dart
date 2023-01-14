import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/camera/camera_cubit.dart';
import 'package:recipe_app/blocs/camera/camera_state.dart';
import '../diyor_pages/language_intro_widgets.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});
  @override
  Widget build(BuildContext context) {
    var cam = false;
    var gal = false;
    return Scaffold(body:
        BlocBuilder<CameraCubit, CameraState>(builder: (context, cameraState) {
      if (cameraState is CameraOpen) {
        cam = cameraState.cameraOpen;
        return add(context, cam, gal);
      }
      if (cameraState is Galere) {
        gal = cameraState.galeryOpen;
        return add(context, cam, gal);
      }
      return add(context, cam, gal);
    }));
  }
}
Widget add(BuildContext context, bool cam, gal) {
  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<CameraCubit>(context).openCamera();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 45,
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<CameraCubit>(context).openGalerea();
                        },
                        icon: const Icon(
                          Icons.sd_storage,
                          size: 45,
                          color: Colors.amber,
                        )),
                  ],
                ),
              ));
        });
  }

  var size = MediaQuery.of(context).size;
  bool opened = false;
  return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      //  backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, left: 21, right: 189),
                  child: Text(
                    'Create recipe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Container(
                    alignment: Alignment.center,
                    //  width: size.width/1.5,
                    height: size.height / 3.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: IconButton(
                          onPressed: () async {
                            //  BlocProvider.of<CameraCubit>(context).openCamera();
                            displayBottomSheet(context);
                            //  BlocProvider.of<CameraCubit>(context).openGalerea();
                          },
                          icon: const Icon(
                            size: 50,
                            Icons.camera_alt_sharp,
                            //  CupertinoIcons.camera_fill,
                            color: Colors.red,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 28, right: 20, left: 20, bottom: 16),
                  child: Container(
                    width: size.width / 0.7.w,
                    height: size.height / 13.h,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: 'Bento lunch box ideas for work|',
                        isDense: false,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: Container(
                    width: size.width / 0.7.w,
                    height: size.height / 10.h,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/People.svg',
                          width: 40,
                          height: 40,
                        ),
                        title: const Text(
                          'Serves',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                  ),
                ),
              ],
            ),
          ],
        )),
      ));
}
