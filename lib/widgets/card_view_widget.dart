import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';

Widget cardView(BuildContext context, Post post) {
  return Column(
    children: [
      InkWell(
        highlightColor: Colors.white.withOpacity(0.4),
        splashColor: Colors.blueGrey.withOpacity(0.6),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
              elevation: 60,
              color: Color.fromARGB(255, 214, 214, 214),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
                image: NetworkImage(
                  post.photo!,
                ),
                fit: BoxFit.cover,
              )

              // child: Container(
              //     alignment: Alignment.center,
              //     height: MediaQuery.of(context).size.height * 0.2,
              //     width: MediaQuery.of(context).size.width * 1,
              //     decoration: BoxDecoration(
              //       // color: Color.fromARGB(255, 227, 222, 222),
              //       // borderRadius: BorderRadius.circular(25),
              //       // border: Border.all(width: 2, color: Colors.red),
              //       image: DecorationImage(
              //         image: NetworkImage(
              //           post.photo!,
              //         ),
              //         fit: BoxFit.cover,
              //       ),
              //     )),
              ),
        ),
      ),
      Text(post.name!),
    ],
  );
}
