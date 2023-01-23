import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var currentUser = FirebaseAuth.instance.currentUser!.uid;

var userDocument =
    FirebaseFirestore.instance.collection('users').doc(currentUser).snapshots();
