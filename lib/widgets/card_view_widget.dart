import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_cubit.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';
import 'package:recipe_app/pages/On%20open/into_card.dart';

Widget cardView(BuildContext context, Post post) {
  var size = MediaQuery.of(context).size;
  final cards = post;
  return Column(
    children: [
      InkWell(
        onLongPress: () {},
        radius: 10000,
        borderRadius: BorderRadius.circular(15),
        highlightColor: Colors.white.withOpacity(0.4),
        splashColor: Colors.red.withOpacity(0.1),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => openedCard(cards),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
              elevation: 20,
              color: const Color.fromARGB(255, 214, 214, 214),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Color.fromARGB(179, 208, 203, 203), width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Hero(
                    tag: '${int.parse(post.id!)}',
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.8,
                      image: NetworkImage(post.photo!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          post.name!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow.withOpacity(0.5),
                          border: Border.all(width: 1, color: Colors.white)),
                      child: IconButton(
                        icon: const Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          BlocProvider.of<SavedCubit>(context).changeBoomark();
                        },
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.78,
        child: Hero(
          tag: cards.header!,
          child: Text(
            post.header!,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
      ),
    ],
  );
}
