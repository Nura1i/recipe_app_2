import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    Size size = MediaQuery.of(context).size;
   return Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          const Padding(
            padding: EdgeInsets.only(top:64,right: 146 ),
            child: Text("Find best ricepes\for cooking",style: TextStyle(
              color: Color(0xFF303030),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28,right: 20,left: 20),
            child: Container(
              width:size.width/0.7.w,
              height: size.height/13.h,
              decoration: BoxDecoration(
               border: Border.all(width: 1,color:Colors.grey),
                borderRadius: BorderRadius.circular(20)               
              ),
            child:const TextField(        
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 13
                ),
                hintText: 'Search recipes',
                isDense: false,
                border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              ),
             ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20,right: 20,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Trending Now🔥',style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w600,
                  ),
                ),
               Row(
                children: [
                  const Text('See All',style: TextStyle(
                fontSize: 15,fontWeight: FontWeight.w600,color: Colors.red
               ),
              ),
               IconButton(onPressed:(){},
                icon:SvgPicture.asset('assets/svg/Belgi.svg',
                width: 30,
                height: 20,
                ),                
                color: Colors.red,
                )
                ],
               )
              ],
            ),
          ),
          Expanded(
             child: SingleChildScrollView(
             // physics:BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
               child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:40 ,
                separatorBuilder:(context, index) {
                 return Container(width: 2,);
                },
                itemBuilder:(context, index) {
                       return    Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                color: Colors.orange,
                    width: 100,
                   // height: 100,
                  ),
                       );
                }, ),
             ),
           )    
        ],
      ),
    ),
   );  
  }
}
