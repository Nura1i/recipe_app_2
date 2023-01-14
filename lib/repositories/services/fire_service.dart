import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_model.dart';

String? username1111;
String? bio;
String? avatarImage;
String? email;

class FireDatabaseService {
  static final _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _databaseFirestore =
      FirebaseFirestore.instance;
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

  void getdata() async {
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

  static Future<bool?> createPost({
    required userModel? usermodel,
    required File? image,
  }) async {
    bool? isCreated = false;
    User? userr = FirebaseAuth.instance.currentUser;
    var uuid = userr!.uid;
    try {
      final userRef = _storage.ref("avatarphoto");
      final nameReferense = userRef.child(usermodel!.id!);
      UploadTask? uploadTask = nameReferense.putFile(image!);
      await uploadTask;
      final avatarImage = await nameReferense.getDownloadURL();
      usermodel = usermodel.copyWith(
          avatarImage: avatarImage,
          email: email,
          username: username1111,
          bio: bio);
      await _databaseFirestore
          .collection('users')
          .doc(uuid)
          .set(usermodel.toJson());
      isCreated = true;
      log('Image put firestore');
      return isCreated;
    } catch (e) {
      log(e.toString());
      return isCreated;
    }
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

  static Future<bool?> updateBio({
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

  static Future<bool?> updateEmail({
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

  static FirebaseFirestore get databaseFirestore => _databaseFirestore;
}
