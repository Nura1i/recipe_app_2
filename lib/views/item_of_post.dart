import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:recipe_app/models/Card%20Model/card_http.dart';

Widget itemOfPost(BuildContext context, Post post) {
  return Slidable(
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      dismissible: DismissiblePane(onDismissed: () {}),
      children: [
        SlidableAction(
          onPressed: (BuildContext context) {
            // BlocProvider.of<ListPostCubit>(context).callUpdatePage(context, post);
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: "Update",
        )
      ],
    ),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          // An action can be bigger than the others.
          onPressed: (BuildContext context) {
            //    BlocProvider.of<ListPostCubit>(context).apiPostDelete(post);
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: NetworkImage(post.photo!)),
          Text(
            post.name!.toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            post.about!,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    ),
  );
}
