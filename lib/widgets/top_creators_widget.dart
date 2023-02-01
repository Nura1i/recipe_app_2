import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';

topCreator(contex, data) {
  return GestureDetector(
      onTap: () {
        Navigator.of(contex).push(MaterialPageRoute(
          builder: (context) => profielOnOpen(data: data),
        ));
      },
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: Container(
            width: 170,
            height: 160,
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 32,
                  foregroundImage: CachedNetworkImageProvider(data[
                          'avatarImage'] ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  data['username'] ?? 'username',
                  style: const TextStyle(color: Colors.white, fontSize: 19),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 5,
          child: RotatedBox(
            quarterTurns: 3,
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.orange),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Colors.white,
              ),
              child: const Text(
                '  TOP',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 242, 21),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ]));
}

topCreatorForAll(contex, dataa) {
  return GestureDetector(
      onTap: () {
        Navigator.of(contex).push(MaterialPageRoute(
          builder: (context) => profielOnOpen(data: dataa),
        ));
      },
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
//                color: Colors.orangeAccent.shade200,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.orange)),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 32,
                  foregroundImage: CachedNetworkImageProvider(dataa[
                          'avatarImage'] ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  dataa['username'] ?? 'username',
                  style: const TextStyle(color: Colors.grey, fontSize: 19),
                )
              ],
            ),
          ),
        ),
      ]));
}
