import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import '../../models/Recipe Model/recipe_model.dart';
import '../../models/user Model/user_model.dart';

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

  // Future<bool?> createPost({
  //   required recipeModel? recipeModel,
  //   required File? image,
  // }) async {
  //   bool? isCreated = false;
  //   User? userr = FirebaseAuth.instance.currentUser;
  //   var uuid = userr!.uid;
  //   try {
  //     final userRef = _storage.ref("PhotoOfRecipes");
  //     final nameReferense = userRef.child(recipeModel!.id!);
  //     UploadTask? uploadTask = nameReferense.putFile(image!);
  //     await uploadTask;
  //     final PhotoOfRecipe = await nameReferense.getDownloadURL();
  //     recipeModel = recipeModel.copyWith(
  //       photo: PhotoOfRecipe,
  //     );
  //     await _databaseFirestore
  //         .collection('users')
  //         .doc(uuid)
  //         .set(recipeModel.toJson());
  //     isCreated = true;
  //     log('Image put firestore');
  //     return isCreated;
  //   } catch (e) {
  //     log(e.toString());
  //     return isCreated;
  //   }
  // }

  static FirebaseFirestore get databaseFirestore => _databaseFirestore;
}
