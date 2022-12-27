import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/pages/notification/all_page.dart';
import 'package:recipe_app/pages/notification/read_page.dart';
import 'package:recipe_app/pages/notification/unread_page.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

class NotificatonPage extends StatefulWidget {
  const NotificatonPage({super.key});

  @override
  State<NotificatonPage> createState() => _NotificatonPageState();
}

class _NotificatonPageState extends State<NotificatonPage>
    with TickerProviderStateMixin {
  late TabController NottabController;
  @override
  void initState() {
    NottabController = TabController(length: 3, vsync: this);
    NottabController.addListener(() {
      setState(() {});
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
      // Page - 4
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: .0,
        title: Text(
          translation(context).notifications,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/Union.svg',
                width: 24,
                height: 24,
              ))
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
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TabBar(
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w600),
                        controller: NottabController,
                        tabs: [
                          Tab(text: translation(context).all),
                          Tab(text: translation(context).unread),
                          Tab(text: translation(context).read)
                        ],
                        unselectedLabelColor: Colors.red,
                        labelColor: Colors.white,
                        indicatorColor: Colors.orange,
                        indicatorWeight: 2,
                        padding: const EdgeInsets.all(4),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: TabBarView(
                        controller: NottabController,
                        children: const [AllPage(), UnreadPage(), ReadPage()])))
          ],
        ),
      ),
    );
  }
}
