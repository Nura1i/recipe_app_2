import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/like%20and%20saved/likedIcon_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/likedIcon_state.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_state.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';
import 'package:recipe_app/pages/home_page.dart';

class openedCard extends StatefulWidget {
  final carrd;

  const openedCard(this.carrd, {super.key});

  @override
  State<openedCard> createState() => _openedCardState();
}

class _openedCardState extends State<openedCard> {
  @override
  Widget build(BuildContext context) {
    var Saved = false;
    var Liked = false;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.red.withOpacity(0.6),
            elevation: 10,
          ),
        ),
        body: BlocBuilder<SavedCubit, SavedState>(
          builder: (context, SavedState savedstate) {
            return BlocBuilder<LikedCubit, LikedState>(
              builder: (context, LikedState likestate) {
                if (likestate is LikedSuccess) {
                  Liked = likestate.success;
                  log('lIKED Succes');
                }
                if (savedstate is SavedSuccess) {
                  Saved = savedstate.success;
                  log('SavedSucces');
                }

                return _intoCard(Liked, Saved);
              },
            );
          },
        )

        // BlocBuilder<SavedCubit, SavedState>(
        //     builder: (BuildContext context, SavedState state) {
        //   BlocBuilder<LikedCubit, LikedState>(
        //       builder: (BuildContext context, LikedState state) {
        //     if (state is LikedSuccess) {
        //       Liked = state.success;
        //     }
        //     return _intoCard(Saved, Liked);
        //   });
        //   if (state is SavedSuccess) {
        //     Saved = state.success;
        //     _intoCard(Saved, Liked);
        //   }
        //   return _intoCard(Saved, Liked);
        // }),
        );
  }

  // Widget like<bool>(bool liked) {
  //   return liked;
  // }

  Widget _intoCard(bool change, bool likeChanges) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 20, left: 20, right: 10),
              child: Text(
                widget.carrd.header,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Hero(
                tag: '${int.parse(widget.carrd!.id!)}',
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.27,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(widget.carrd!.photo!),
                          fit: BoxFit.cover)),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 29,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('1391'),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.53,
                ),
                GestureDetector(
                    onTap: () {
                      BlocProvider.of<LikedCubit>(context).changeLike();
                    },
                    child: BlocProvider.of<LikedCubit>(context).icLike),

                // const Icon(
                //   Icons.favorite_border,
                //   size: 33,
                // ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      BlocProvider.of<SavedCubit>(context).changeBoomark();
                    },
                    child: BlocProvider.of<SavedCubit>(context).icBook),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                widget.carrd.about,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
