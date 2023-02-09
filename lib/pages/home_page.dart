import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/card%20block/list_post_cubit.dart';
import 'package:recipe_app/blocs/card%20block/list_post_state.dart';
import 'package:recipe_app/models/Api%20Miliy%20Taom%20Model/card_http.dart';
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
    BlocProvider.of<ListPostCubit>(context).apiPostList();
    BlocProvider.of<ListPostCubit>(context).runner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<ListPostCubit, ListPostState>(
        builder: (BuildContext context, ListPostState state) {
          if (state is ListPostLoaded) {
            posts = state.posts!;
            return const HomeView2();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// Uzbek National recipes Homedagi ko'rinish qismi...!
Widget builder(List<Post> items) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (contex, index) {
      return cardView(contex, posts[index]);
    },
  );
}

// Uzbek National Recipes See All qismi
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
