import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
        title: const Text('My Profile',style:
          TextStyle(fontSize: 24,fontWeight:FontWeight.w600,color: Colors.black)
           ),
           actions: [
                 IconButton(onPressed:(){},
               icon: SvgPicture.asset('assets/svg/ProfileUnion.svg',
             width: 24,height: 24,color: Colors.black,)
             )
           ],
         ),
      );
     
  
  }
}