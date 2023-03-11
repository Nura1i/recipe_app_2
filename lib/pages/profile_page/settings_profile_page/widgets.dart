import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

TextEditingController? controllerUserName =
    TextEditingController(text: username1111.toString());
TextEditingController? controllerBio =
    TextEditingController(text: bio.toString());
TextEditingController? controllerEmail =
    TextEditingController(text: email.toString());
Future<bool?> yourProfileSetting() async {
  userModel model = const userModel();
  try {
    model = model.copyWith(
        bio: controllerBio!.text,
        email: controllerEmail!.text,
        username: controllerUserName!.text);
    FireDatabaseService.updateItemCollection(usermodelll: model);

    log('your settings sets');
  } catch (e) {
    log(e.toString());
  }
  return null;
}

buildTextField(
  BuildContext context,
  String labelText,
  String placeholder,
  TextEditingController controller,
  bool? maxlength,
  bool? emaillength,
) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 25.0,
    ),
    child: TextField(
      autocorrect: false,
      enableSuggestions: false,
      textAlign: TextAlign.left,
      cursorColor: Colors.blueAccent,
      maxLines: maxlength == false ? 2 : 1,
      maxLength: maxlength == emaillength
          ? 25
          : emaillength == false
              ? 35
              : 100,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 13.sp,
            fontFamily: "Lora",
            fontWeight: FontWeight.bold,
          ),
      controller: controller,
      decoration: InputDecoration(
        isDense: false,
        contentPadding: const EdgeInsets.only(bottom: 3, left: 5),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12.sp,
              fontFamily: "Lora",
            ),
        hintText: placeholder,
        hintStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "Lora"),
      ),
    ),
  );
}

List<String> items = ['Delete  Image'];
Widget deleteImage() {
  return DropdownButton<String>(
    icon: const Icon(Icons.delete),
    items: const [],
    onChanged: (value) {},
  );
}

XFile? imageCamera;
XFile? imageGalery;
void cropperBottomSheet(BuildContext context) {
  ImagePicker imagePicker = ImagePicker();

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
                      onPressed: () async {
                        imageCamera ==
                            await imagePicker.pickImage(
                              source: ImageSource.camera,
                            );
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
                        imageCamera ==
                            await imagePicker.pickImage(
                              source: ImageSource.camera,
                            );

                        //  Navigator.of(context)
                        //                     .push(MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const CropperScreenn(),
                        //                 ));
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/gallery.svg',
                      )),
                ],
              ),
            ));
      });
}
