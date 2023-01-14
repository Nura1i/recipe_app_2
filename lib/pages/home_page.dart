import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/card%20block/list_post_cubit.dart';
import 'package:recipe_app/blocs/card%20block/list_post_state.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';
import 'package:recipe_app/views/home_view.dart';
import 'package:recipe_app/views/see_all_card.dart';
import 'package:recipe_app/widgets/card_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var posts;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: BlocBuilder<ListPostCubit, ListPostState>(
          builder: (BuildContext context, ListPostState state) {
            if (state is ListPostLoaded) {
              posts = state.posts!;
              // builder(posts);
              return const HomeView();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

Widget builder(List<Post> items) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (contex, index) {
      return cardView(contex, posts[index]);

      // Shimmer.fromColors(
      //   highlightColor: Colors.white,
      //   baseColor: Colors.grey.shade400,
      //   child: cardView(contex, posts[index]),
      //   period: Duration(seconds: time),
      //   enabled: true,
      // );

      //cardView(contex, posts[index]);
    },
  );
}

Widget builderAll(List<Post> items) {
  return GridView.builder(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: items.length,
    itemBuilder: (contex, index) {
      return seeAllView(contex, posts[index]);
    },
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  );
}
