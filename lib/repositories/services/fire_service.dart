import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:recipe_app/models/Recipe%20Model/recipe_model.dart';
import 'package:recipe_app/models/user%20Model/user_model.dart';
import 'package:recipe_app/pages/profile_page/settings_profile_page/widgets.dart';
import 'package:recipe_app/pages/sign_in_page.dart';

import 'package:shared_preferences/shared_preferences.dart' as ShP;

String? username1111;
String? bio;
String? avatarImage;
String? email;
List? UserRecepts;
List? allRecepts;
int? totalCountLikes;

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

  static getUserFromRecept(userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc;
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
      recipes = userDoc.get('recepts') ?? [];
      recipes.add(recipe!.id);

      await _databaseFirestore
          .collection('users')
          .doc(currentUserId)
          .update({'recepts': recipes});
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
    // Navigator.of(ctx).pop();
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

  static Future deletePost(postId) async {
    try {
      DocumentSnapshot postDoc = await FirebaseFirestore.instance
          .collection('Recipes')
          .doc(postId['id'])
          .get();
      List likes = postDoc['totalLikes'] ?? [];

      await _databaseFirestore.collection('Recipes').doc(postId['id']).delete();
      await _databaseFirestore
          .collection('BlokRecipes')
          .doc(postId['id'])
          .delete();
      log('deleted');
      await _storage.refFromURL(postId['photo']).delete();
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      List userLikes = userDoc['totalLikes'] ?? [];
      for (var element in likes) {
        userLikes.remove(element);
      }

      List lsPost = userDoc.get('recepts') ?? [];
      List lsSaved = userDoc.get('saved') ?? [];

      if (lsPost.contains(postId['id'])) {
        lsPost.remove(postId['id']);
      }
      if (lsSaved.contains(postId['id'])) {
        lsSaved.remove(postId['id']);
      }
      _databaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
              {'recepts': lsPost, 'saved': lsSaved, 'totalLikes': userLikes});
      log('Deleted Success');
    } catch (e) {
      log(e.toString());
    }
  }

  static Future cancelBlokPost(postId) async {
    await _databaseFirestore
        .collection('BlokRecipes')
        .doc(postId['id'])
        .delete();
  }

  static Future topCreators() async {
    final QuerySnapshot<Map<String, dynamic>> allusersDoc;
    var ref = FirebaseFirestore.instance.collection('users');
    allusersDoc = await ref.get();
    List ls = allusersDoc.docs;
    Map<String, dynamic>? topUserId = {};
    int max = 0;

    for (var element in ls) {
      if (element.data()['totalLikes'] != null) {
        if (max < element.data()['totalLikes'].length) {
          topUserId[element.data()['id'].toString()] =
              element.data()['totalLikes'].length;
        }
      }
    }

    var sortedByValueMap = Map.fromEntries(topUserId.entries.toList()
      ..sort((e1, e2) => e1.value.compareTo(e2.value)));
    final reverseM =
        LinkedHashMap.fromEntries(sortedByValueMap.entries.toList().reversed);
    List topItems = [];
    for (int i = 0; i < 9; i++) {
      topItems.add(reverseM.keys.elementAt(i));
    }
    return topItems;
  }

  static Future<bool?> updateItemCollection({
    required userModel? usermodelll,
  }) async {
    bool? isput = false;
    //TextEditingController controller ;
    User? userr = FirebaseAuth.instance.currentUser;
    var uuid = userr!.uid;
    try {
      await _databaseFirestore.collection('users').doc(uuid).update({
        'bio': controllerBio!.text,
        'username': controllerUserName!.text,
        'email': controllerEmail!.text
      });

      log('saved bio end email');
      await getdata();
    } catch (e) {
      log(e.toString());
    }

    return isput;
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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();
      List ls = [];
      ls = userDoc.get('totalLikes') ?? [];
      totalLikes = recipeDoc.get('totalLikes') ?? [];
      List supLike = recipeDoc.get('totalLikes') ?? [];
      DocumentSnapshot ownRecipeDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(recipeDoc.get('userId'))
          .get();

      List ownRecipeLikeList = ownRecipeDoc.get('totalLikes') ?? [];

      if (liked == false) {
        if (!totalLikes.contains(currentUserId)) {
          totalLikes.add(currentUserId);
        }
      }
      if (liked == true) {
        if (totalLikes.contains(currentUserId)) {
          totalLikes.remove(currentUserId);
          // ls.remove(currentUserId);
        }
      }
      await _databaseFirestore
          .collection('Recipes')
          .doc(recipeID)
          .update({'totalLikes': totalLikes});

      if (currentUserId == recipeDoc.get('userId')) {
        for (var element in supLike) {
          ls.remove(element);
        }
      }
      if (currentUserId == recipeDoc.get('userId')) {
        for (var element in totalLikes) {
          ls.add(element);
        }
      }
      if (currentUserId != recipeDoc.get('userId')) {
        for (var element in supLike) {
          ownRecipeLikeList.remove(element);
        }

        for (var element in totalLikes) {
          ownRecipeLikeList.add(element);
        }

        await _databaseFirestore
            .collection('users')
            .doc(recipeDoc.get('userId'))
            .update({'totalLikes': ownRecipeLikeList});
      }
      await _databaseFirestore
          .collection('users')
          .doc(currentUserId)
          .update({'totalLikes': ls});

      return log('LikedSuccess');
    } catch (e) {
      log(e.toString());
    }
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

      log('Profile image delete');
      isDeleted = true;
    } catch (e) {
      log(e.toString());
      return isDeleted;
    }
    return null;
  }

  static Future<bool?> blockRecipes(
      {required recipeData, required rule}) async {
    bool userSaved = false;
    try {
      recipeModel recipe = recipeModel(
        photo: recipeData['photo'],
        totalLike: rule,
        //totalLikes: recipeData['totalLikes'],
        cookTime: recipeData['cookTime'],
        head: recipeData['head'],
        categorie: recipeData['categorie'],
        serves: recipeData['serves'],
        userId: recipeData['userId'],
        id: recipeData['id'],
        text: recipeData['text'],
        items: recipeData['items'],
      );

      await _databaseFirestore
          .collection('BlokRecipes')
          .doc(recipeData['id'])
          .set(recipe.toJson());

      userSaved = true;
      return userSaved;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static signOutUser(context) async {
    await FirebaseAuth.instance.signOut();

    final prefs = await ShP.SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
        (route) => false);
  }

  static FirebaseFirestore get databaseFirestore => _databaseFirestore;
}
