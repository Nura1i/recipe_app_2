import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          const Padding(
            padding: EdgeInsets.only(top:64,left: 22,right: 146 ),
            child: Text("Find best ricepes\for cooking",style: TextStyle(
              color: Color(0xFF303030),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
           child: TextField(
           
           ),
          )
         
        ],
      ),
    ),
   );
    
  }
}
