import 'package:flutter/material.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';
import 'package:recipe_app/pages/On%20open/into_card.dart';

Widget seeAllView(BuildContext context, Post post) {
  var size = MediaQuery.of(context).size;
  final cards = post;
  return SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    child: Column(
      children: [
        InkWell(
          highlightColor: Colors.white.withOpacity(0.4),
          splashColor: Colors.blueGrey.withOpacity(0.6),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => openedCard(cards),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
            child: Card(
                elevation: 0,
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
                      tag: '${int.parse(cards.id!)}',
                      child: Image(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.8,
                        image: NetworkImage(post.photo!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
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
                            color: Colors.red.withOpacity(0.5),
                            border: Border.all(width: 1, color: Colors.white)),
                        child: IconButton(
                          icon: const Icon(
                            Icons.bookmark_border,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        // SizedBox(
        //   //  width: MediaQuery.of(context).size.width * 0.78,
        //   child: Text(
        //     post.header!,
        //     style: const TextStyle(
        //         fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
        //   ),
        // ),
      ],
    ),
  );
}
