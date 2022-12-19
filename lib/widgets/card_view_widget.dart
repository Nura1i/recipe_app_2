import 'package:flutter/material.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';

Widget cardView(BuildContext context, Post post) {
  return Column(
    children: [
      InkWell(
        highlightColor: Colors.white.withOpacity(0.4),
        splashColor: Colors.blueAccent.withOpacity(0.5),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 227, 222, 222),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 2, color: Colors.red),
                image: DecorationImage(
                  image: NetworkImage(
                    post.photo!,
                  ),
                  fit: BoxFit.cover,
                ),
              )),
        ),
      ),
      Text(post.name!),
    ],
  );
}
