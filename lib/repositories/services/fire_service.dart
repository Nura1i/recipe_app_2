import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

class FireDatabaseService {
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

  static FirebaseFirestore get databaseFirestore => _databaseFirestore;
}
