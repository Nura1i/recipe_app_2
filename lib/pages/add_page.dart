import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
      ),
      body:SafeArea(child:Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children:const [
           Padding(padding:
           EdgeInsets.only(top: 16,left: 21,right: 189),
           child: Text('Create recipe',style:
            TextStyle(fontSize: 24,fontWeight:FontWeight.w600),),
          )
         ],
       )
     )
    );
  }
}