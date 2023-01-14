import 'package:flutter/material.dart';
class UserHomePage extends StatelessWidget {
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [
          MyPost1(),
          MyPost2(),
          MyPost3(),
        ],
      ),
    );
  }
}

class MyPost1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      username: 'createdbykoko',
      videoDescription: 'tiktok ui tutorial',
      numberOfLikes: '1.2M',
      numberOfComments: '1232',
      numberOfShares: '122',
      userPost:  Container(
        width: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/images/taom1.jpg',),
        fit:BoxFit.cover )),
      
      ),
    );
  }
}
class MyPost2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      username: 'zuckerberg',
      videoDescription: 'reels for days',
      numberOfLikes: '1.2M',
      numberOfComments: '232',
      numberOfShares: '122',
      userPost: Container(
        width: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/images/login_view.jpg',),
        fit:BoxFit.cover )),
      
      ),
    );
  }
}

class MyPost3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      username: 'randomUser',
      videoDescription: 'flutter tutorial',
      numberOfLikes: '1.2B',
      numberOfComments: '232',
      numberOfShares: '122',
      userPost: Container(
        width: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/images/taom1.jpg',),
        fit:BoxFit.cover )),
      
      ),
    );
  }
}


class PostTemplate extends StatelessWidget {
  final String username;
  final String videoDescription;
  final String numberOfLikes;
  final String numberOfComments;
  final String numberOfShares;
  final userPost;

  PostTemplate({
    required this.username,
    required this.videoDescription,
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.numberOfShares,
    required this.userPost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // user post (at the very back)
          userPost,

          // user name and caption
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Container(
              alignment: Alignment(-1, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('@' + username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: videoDescription,
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                            text: ' #fyp #flutter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // buttons
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              alignment: Alignment(1, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    icon: Icons.favorite,
                    number: numberOfLikes,
                  ),
                  MyButton(
                    icon: Icons.chat_bubble_outlined,
                    number: numberOfComments,
                  ),
                  MyButton(
                    icon: Icons.send,
                    number: numberOfShares,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final icon;
  final String number;

  MyButton({this.icon, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,color: Colors.red,
          ),
          SizedBox(
            height: 10,
          ),
          Text(number,style: TextStyle(color:Colors.black),),
        ],

        
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:recipe_app/pages/notification/all_page.dart';
// import 'package:recipe_app/pages/notification/read_page.dart';
// import 'package:recipe_app/pages/notification/unread_page.dart';

// class NotificatonPage extends StatefulWidget {
//   const NotificatonPage({super.key});

//   @override
//   State<NotificatonPage> createState() => _NotificatonPageState();
// }

// class _NotificatonPageState extends State<NotificatonPage>with TickerProviderStateMixin {
//    late TabController NottabController;
//   @override
//   void initState() {
//    NottabController=TabController(length: 3,vsync: this);
//    NottabController.addListener(() {
//     setState(() {
      
//     });
//    });
//     super.initState();
//   }
//   @override
//   void dispose() {
//     NottabController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//    // dynamic bookmarkpagel=[AllPage(),UnreadPage(),ReadPage()];
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       appBar: AppBar(
//      backgroundColor: Theme.of(context).backgroundColor,
//         elevation: .0,
//         title:const Text('Notifications',style: 
//         TextStyle(fontSize: 24,fontWeight:FontWeight.w600,color: Colors.black),),
//         actions: [
//           IconButton(onPressed:(){},
//            icon:SvgPicture.asset('assets/svg/Union.svg',width: 24,height: 24,))
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//               const SizedBox(
//                   height: 32,
//                 ),
//                 Container(        
//                   width: MediaQuery.of(context).size.height,
//                   decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(width: 1,color: Colors.black),
//                   borderRadius: BorderRadius.circular(10)),
//                    child: Column(
//                    children: [
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child:TabBar(
  
//                           labelStyle: TextStyle(fontWeight: FontWeight.w600),
//                           controller:NottabController ,  
//                           tabs: const [
//                              Tab(text: 'All',),
//                               Tab(text: 'Unread',),
//                               Tab(text: 'Read',)                              
//                           ],
//                           unselectedLabelColor: Colors.red,
//                              labelColor:Colors.white,
//                             indicatorColor: Colors.orange,
//                             indicatorWeight: 2,
//                             padding:const EdgeInsets.all(4  ),
//                            indicator: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                            color: Colors.red,
//                          ),
//                        )                      
//                       )
//                      ],
//                     ),
//                    ),
//                       Expanded(child:
//                   Padding(
//                     padding: const EdgeInsets.all(1),
//                     child: TabBarView(
//                     controller:NottabController,
//                      children:const [
//                       AllPage(),
//                       UnreadPage(),
//                       ReadPage()
//                      ]
//                     )
//                   )
//                 )
          
//           ],
//         ),
//       ),
//     );
//   }
// }
