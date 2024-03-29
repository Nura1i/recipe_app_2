import 'package:carousel_slider/carousel_slider.dart';
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
List? Topusers;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
    BlocProvider.of<ListPostCubit>(context).runner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<ListPostCubit, ListPostState>(
        builder: (BuildContext context, ListPostState state) {
          if (state is ListPostLoaded) {
            posts = state.posts!;
            Topusers = state.result;

            return HomeView2(
              topUsers: Topusers,
            );
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
  return CarouselSlider.builder(
    itemCount: items.length,
    itemBuilder: (context, index, realIndex) => cardView(context, posts[index]),
    options: CarouselOptions(
      height: 400,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      scrollDirection: Axis.horizontal,
    ),
  );
}

// Uzbek National Recipes See Allni ichki qismi...!
Widget builderAll(List<Post> items) {
  return GridView.builder(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: items.length,
    shrinkWrap: true,
    itemBuilder: (contex, index) {
      return seeAllView(contex, posts[index]);
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
  );
}
