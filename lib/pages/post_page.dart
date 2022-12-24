import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/card%20block/list_post_cubit.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';
import 'package:recipe_app/views/item_of_post.dart';

import '../blocs/card block/list_post_state.dart';

class post_page extends StatefulWidget {
  const post_page({Key? key}) : super(key: key);

  @override
  State<post_page> createState() => _post_pageState();
}

class _post_pageState extends State<post_page> {
  //List<Post> items = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
         backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("BloC"),
      ),
      body: BlocBuilder<ListPostCubit, ListPostState>(
        builder: (BuildContext context, ListPostState state) {
          if (state is ListPostError) {
            return viewOfError(state.error);
          }

          if (state is ListPostLoaded) {
            var items = state.posts!;
            return viewOfPostList(items);
          }

          return viewOfLoading();
        },
      ),
    );
  }

  Widget viewOfError(String err) {
    return Center(
      child: Text("Error occurred $err"),
    );
  }

  Widget viewOfLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Widget viewOfPostList(List<Post> items) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (ctx, index) {
      return itemOfPost(ctx, items[index]);
    },
  );
}
