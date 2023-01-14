import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/publish_profile/bio_username_email/bio_username_email_cubit.dart';
import 'package:recipe_app/blocs/publish_profile/publishimage_cubit.dart';
import 'package:recipe_app/models/user_model.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

import 'settings_profile_text_fild_widgets.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 201, 187, 146),
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Edit Profile",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
                child: Stack(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        BlocProvider.of<ImagePublishCubit>(context)
                            .openCropper(context, imagee);
                      },
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: avatarImage != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(avatarImage!))
                                : avatarImage != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(avatarImage!))
                                    : const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                        ))),
                        child: Center(
                          child: avatarImage != null
                              ? const SizedBox.shrink()
                              : const CupertinoActivityIndicator(),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ],
            )),
            const SizedBox(
              height: 35,
            ),
            buildTextField( context, 'UserName', 'UserName',  controllerUserName!),
            buildTextField(context, 'Bio', 'Bio', controllerBio!),
            buildTextField(context, 'Email', 'Email', controllerEmail!),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  child: const Text("CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                ElevatedButton(
                    child: const Text('Saved'),
                    onPressed: () async {
                      yourProfileSetting();
                      Navigator.of(context).pop();
                      // userModel model = const userModel();
                      // model = model.copyWith(
                      //  avatarImage: avatarImage,
                      //     bio: controllerBio!.text,
                      //     email: controllerEmail!.text,
                      //     username: controllerUserName!.text);
                      // FireDatabaseService.updateItemCollection(
                      //   usermodelll: model,
                      // );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
