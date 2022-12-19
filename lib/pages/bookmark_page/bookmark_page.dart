import 'package:flutter/material.dart';
import 'package:recipe_app/pages/bookmark_page/recipe_page.dart';
import 'package:recipe_app/pages/bookmark_page/video_pages.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic bookmarkpagel = [VideoPage(), RecipeMarkPage()];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 22, top: 64, right: 181),
              child: Text(
                'Saved Recipes',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TabBar(
                        labelStyle: TextStyle(fontWeight: FontWeight.w600),
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Video',
                          ),
                          Tab(
                            text: 'Recipe',
                          )
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
                      controller: tabController,
                      children: const [VideoPage(), RecipeMarkPage()],
                    )))
          ],
        ),
      ),
    );
  }
}
