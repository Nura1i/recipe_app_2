import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/pages/On%20open/into_recipe.dart';

recentAdded(contex, data) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(data['userId'])
          .snapshots(),
      builder: (context, snapshot) {
        final userData = snapshot.data;

        return GestureDetector(
            onTap: () {
              Navigator.of(contex).push(MaterialPageRoute(
                builder: (context) =>
                    recipeOpen(postData: data, userData: userData),
              ));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120.h,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.grey),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(data['photo']),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: data['head'].toString().length > 22 ? 250 : null,
                  child: Text(
                    data['head'],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ));
      });
}

recentAddedForAll(contex, data) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        final userData = snapshot.data;
        return GestureDetector(
            onTap: () {
              Navigator.of(contex).push(MaterialPageRoute(
                builder: (context) =>
                    recipeOpen(postData: data, userData: userData),
              ));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            data['photo'],
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
      });
}
