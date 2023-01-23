import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/Recipe%20Model/recipe_model.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';
import 'package:recipe_app/views/sign_in_view.dart';

String? username1111;
String? bio;
String? avatarImage;
String? UrlavatarImage;
String? email;


class FireDatabaseService {
  static final FirebaseFirestore _databaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference recipesList =
      FirebaseFirestore.instance.collection('Recipes');
  static final _storage = FirebaseStorage.instance;

  static Future<bool?> saveUserToCollection({required userModel user}) async {
    bool userSaved = false;
    try {
      await _databaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
      userSaved = true;
      return userSaved;
    } catch (e) {
      log(e.toString());
    }
    return userSaved;
  }

  static Future<bool?> SaveRecipeToCollection(
      {required recipeModel? recipe, required File? image}) async {
    bool recipeSaved = false;

    try {
      final userRef = _storage.ref("PhotoOfRecipes");
      final nameReferense = userRef.child(recipe!.id!);
      UploadTask? uploadTask = nameReferense.putFile(image!);
      await uploadTask;
      final PhotoOfRecipe = await nameReferense.getDownloadURL();
      recipe = recipe.copyWith(
        photo: PhotoOfRecipe,
      );
      await _databaseFirestore
          .collection('Recipes')
          .doc(recipe.id)
          .set(recipe.toJson());
      recipeSaved = true;
      return recipeSaved;
    } catch (e) {
      log(e.toString());
    }
    return recipeSaved;
  }

  static Future getdata() async {
    User? userr = FirebaseAuth.instance.currentUser;
    var uuid = userr!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uuid).get();
    username1111 = userDoc.get('username');
    bio = userDoc.get('bio');
    email = userDoc.get('email');
    avatarImage = userDoc.get('avatarImage');
    //log(username1111!);
  }

  static Future<String?> updateProfile({
    required userModel? usermodel,
    required File? image,
  }) async {
    log('Work creatPost');

    User? userr = FirebaseAuth.instance.currentUser;
    var uuid = userr!.uid;
    try {
      final userRef = _storage.ref("avatarphoto");
      final nameReferense = userRef.child(usermodel!.id!);
      UploadTask? uploadTask = nameReferense.putFile(image!);

      await uploadTask;
      final downloadUrl = await nameReferense.getDownloadURL();

      final CollectionReference users = databaseFirestore.collection("users");
      String? url = downloadUrl;
      await users.doc(uuid).update({'avatarImage': url});
      final DocumentSnapshot<Object?> result;
      result = await users.doc(uuid).get();
      log('your image success get');
      return result['avatarImage'];
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
  static Future<bool?> updateItemCollection({
    required userModel? usermodelll,})
     async {
    bool? isput = false;
    User? userr = FirebaseAuth.instance.currentUser;
    var uuid = userr!.uid;
    try {
      await _databaseFirestore
          .collection('users')
          .doc(uuid)
          .set(usermodelll!.toJson());
    } catch (e) {
      log(e.toString());
    }

    return isput;
  }

  static Future<bool?> ProfileImageDelete() async {
    bool? isDeleted = false;
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      await _storage.refFromURL(userDoc['avatarImage']).delete();

      await _databaseFirestore
          .collection('users')
          .doc(userId)
          .update({'avatarImage': null});

      isDeleted = true;
    } catch (e) {
      log(e.toString());
      return isDeleted;
    }
    return null;
  }

  static void signOutUser(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SignInView(),
        ),
        (route) => false);
  }

  static FirebaseFirestore get databaseFirestore => _databaseFirestore;
}
