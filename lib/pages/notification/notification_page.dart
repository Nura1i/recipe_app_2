import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/pages/notification/all_page.dart';
import 'package:recipe_app/pages/notification/read_page.dart';
import 'package:recipe_app/pages/notification/unread_page.dart';

class NotificatonPage extends StatefulWidget {
  const NotificatonPage({super.key});

  @override
  State<NotificatonPage> createState() => _NotificatonPageState();
}

class _NotificatonPageState extends State<NotificatonPage>with TickerProviderStateMixin {
   late TabController NottabController;
  @override
  void initState() {
   NottabController=TabController(length: 3,vsync: this);
   NottabController.addListener(() {
    setState(() {
      
    });
   });
    super.initState();
  }
  @override
  void dispose() {
    NottabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   // dynamic bookmarkpagel=[AllPage(),UnreadPage(),ReadPage()];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: .0,
        backgroundColor: Colors.white,
        title:const Text('Notifications',style: 
        TextStyle(fontSize: 24,fontWeight:FontWeight.w600,color: Colors.black),),
        actions: [
          IconButton(onPressed:(){},
           icon:SvgPicture.asset('assets/svg/Union.svg',width: 24,height: 24,))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
              const SizedBox(
                  height: 32,
                ),
                Container(        
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
                   child: Column(
                   children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:TabBar(
  
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
                          controller:NottabController ,  
                          tabs: const [
                             Tab(text: 'All',),
                              Tab(text: 'Unread',),
                              Tab(text: 'Read',)                              
                          ],
                          unselectedLabelColor: Colors.red,
                             labelColor:Colors.white,
                            indicatorColor: Colors.orange,
                            indicatorWeight: 2,
                            padding:const EdgeInsets.all(4  ),
                           indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                           color: Colors.red,
                         ),
                       )                      
                      )
                     ],
                    ),
                   ),
                      Expanded(child:
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: TabBarView(
                    controller:NottabController,
                     children:const [
                      AllPage(),
                      UnreadPage(),
                      ReadPage()
                     ]
                    )
                  )
                )
          
          ],
        ),
      ),
    );
  }
}
