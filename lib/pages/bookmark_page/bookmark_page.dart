import 'package:flutter/material.dart';
import 'package:recipe_app/pages/bookmark_page/recipe_page.dart';
import 'package:recipe_app/pages/bookmark_page/video_pages.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';

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
      // Page - 2
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 22,
                top: 20,
              ),
              child: Text(
                translation(context).savedRecipes,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
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
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w600),
                        controller: tabController,
                        tabs: [
                          Tab(
                            text: translation(context).video,
                          ),
                          Tab(
                            text: translation(context).recipe,
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
