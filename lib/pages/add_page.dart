import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/blocs/camera/camera_cubit.dart';
import 'package:recipe_app/blocs/camera/camera_state.dart';
import 'package:recipe_app/widgets/bottomsheet.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cam = false;
    var gal = false;
    var image;
    return Scaffold(body:
        BlocBuilder<CameraCubit, CameraState>(builder: (context, cameraState) {
      if (cameraState is CameraOpen) {
        cam = cameraState.cameraOpen;
        return add(context, cam, gal, image);
      }
      if (cameraState is imagePick) {
        image = cameraState.imagepick;
      }
      return add(context, cam, gal, image);
    }));
  }
}

Widget add(BuildContext context, bool cam, gal, img) {
  var size = MediaQuery.of(context).size;
  bool opened = false;
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.02, left: size.width * 0.05),
                child: const Text(
                  'Create recipe',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: img != null ? null : size.height / 3.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[300],
                      ),
                      child: img != null
                          ? Image.file(
                              img,
                              // width: 500,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: IconButton(
                                  onPressed: () async {
                                    displayBottomSheet(context);
                                  },
                                  icon: const Icon(
                                    size: 50,
                                    Icons.camera_alt_sharp,
                                    //  CupertinoIcons.camera_fill,
                                    color: Colors.red,
                                  )),
                            ),
                    ),
                    img != null
                        ? Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      displayBottomSheet(context);
                                    },
                                    icon: const Icon(
                                      size: 50,
                                      Icons.camera_alt_sharp,
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  width: 50,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      BlocProvider.of<CameraCubit>(context)
                                          .deletePhoto();
                                    },
                                    icon: const Icon(
                                      size: 50,
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 28, right: 20, left: 20, bottom: 16),
                child: Container(
                  width: size.width / 0.7.w,
                  height: size.height / 13.h,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(20)),
                  child: const TextField(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    maxLines: 2,
                    maxLength: 60,
                    showCursor: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: ' Main text',
                      counterText: ' ',
                      hintStyle: TextStyle(fontSize: 17),
                      isDense: false,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: Container(
                  width: size.width / 0.7.w,
                  height: size.height / 13.h,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/People.svg',
                        width: 35,
                        height: 35,
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
        ),
      ));
}
