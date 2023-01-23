import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_app/models/Recipe%20Model/recipe_model.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';
import 'package:recipe_app/views/sign_in_view.dart';

String? username1111;
String? bio;
String? avatarImage;
String? email;
List? UserRecepts;
List? allRecepts;

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

  static Future SaveRecipeToCollection(
      {required recipeModel? recipe, required File? image}) async {
    bool recipeSaved = false;

    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      List recipes = [];
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();
      recipes = userDoc.get('recepts');
      recipes.add(recipe!.id);

      await _databaseFirestore
          .collection('users')
          .doc(currentUserId)
          .update({'recepts': recipes}).then((value) {
        log(allRecepts.toString());
      });
      final userRef = _storage.ref("PhotoOfRecipes");
      final nameReferense = userRef.child(recipe.id!);
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
      return log('Recept Posted success');
    } catch (e) {
      log(e.toString());
    }
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
    required userModel? usermodelll,
  }) async {
    bool? isput = false;
    //TextEditingController controller ;
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

  static Future<bool?> deletePostById({required userModel? usermodel}) async {
    bool? isDeleted = false;

    try {
      final deleteRef = _storage.refFromURL(usermodel!.avatarImage!);
      await deleteRef.delete();
      await _databaseFirestore.collection('users').doc(usermodel.id).delete();
      isDeleted = true; // tushunarsiz joylari mavjud
    } catch (e) {
      log(e.toString());
      return isDeleted;
    }
    return null;
  }

  static Future saved(recipeID, saved) async {
    try {
      List savedList = [];
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();
      savedList = userDoc.get('saved') ?? [];
      if (saved == false) {
        if (!savedList.contains(recipeID)) {
          savedList.add(recipeID);
        }
      }
      if (saved == true) {
        if (savedList.contains(recipeID)) {
          savedList.remove(recipeID);
        }
      }

      await _databaseFirestore
          .collection('users')
          .doc(currentUserId)
          .update({'saved': savedList}).then((value) {});

      return log('SavedSuccess');
    } catch (e) {
      log(e.toString());
    }
  }

  static Future like(recipeID, liked) async {
    try {
      List totalLikes = [];
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot recipeDoc = await FirebaseFirestore.instance
          .collection('Recipes')
          .doc(recipeID)
          .get();
      totalLikes = recipeDoc.get('totalLikes') ?? [];

      if (liked == false) {
        if (!totalLikes.contains(currentUserId)) {
          totalLikes.add(currentUserId);
        }
      }
      if (liked == true) {
        if (totalLikes.contains(currentUserId)) {
          totalLikes.remove(currentUserId);
        }
      }
      await _databaseFirestore
          .collection('Recipes')
          .doc(recipeID)
          .update({'totalLikes': totalLikes}).then((value) {
        log(totalLikes.toString());
      });

      return log('LikedSuccess');
    } catch (e) {
      log(e.toString());
    }
  }

  // static Future<bool?> sendMssage({required MessageModel message}) async {
  //   bool? messageCreated = false;
  //   try {
  //     final userDocument = await _databaseFirestore
  //         .collection('users')
  //         .doc(message.userId)
  //         .get();

  //     final UserModel user = UserModel.fromJson(userDocument.data()!);
  //     message = message.copyWith(username: user.userName);
  //     await _databaseFirestore
  //         .collection('messages')
  //         .doc(message.id)
  //         .set(message.toJson());
  //     messageCreated = true;
  //     return messageCreated;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return messageCreated;
  // }

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

  static void signOutUser(context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SignInView(),
        ),
        (route) => false);
  }

  static FirebaseFirestore get databaseFirestore => _databaseFirestore;
}
