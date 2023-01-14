
//     import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:recipe_app/models/user_model.dart';
// import 'package:recipe_app/pages/profile_page/settings_profile_page/image_cropper.dart';
// import 'package:recipe_app/pages/profile_page/settings_profile_page/settings_profile.dart';
// import 'package:recipe_app/repositories/services/fire_service.dart';

// bool? isEnabled = true;
//   bool? isLoading = false;
//   void publish() async {
//     isEnabled = true;
//     isLoading = true;

//     try {
//       userModel usermodel11 = userModel(
//         id: FirebaseAuth.instance.currentUser!.uid,
//       );
//       file = File(image!.path);
//       final isPublished = await FireDatabaseService.createPost(
//           usermodel: usermodel11, image: file);

//       if (isPublished != null) {
//         debugPrint('PUBLISHED');
//         isLoading = false;

//  // Blocga Otqazish uchun

//        // setState(() {});



//       }
//       debugPrint('PUBLISHED');
//       // setState(() {});
//     } catch (e) {
//       log(e.toString());
//     }
//   }
