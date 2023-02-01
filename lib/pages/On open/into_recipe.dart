import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_cubit.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_state.dart';
import 'package:recipe_app/consts/consts.dart';
import 'package:recipe_app/pages/On%20open/profile_open.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/widgets/alertForDeletPost.dart';

//

class recipeOpen extends StatefulWidget {
  final postData;
  final userData;

  const recipeOpen({super.key, this.postData, this.userData});

  @override
  State<recipeOpen> createState() => _recipeOpenState();
}

class _recipeOpenState extends State<recipeOpen> {
  @override
  void initState() {
    BlocProvider.of<SavedCubit>(context).saved(widget.postData);
    BlocProvider.of<SavedCubit>(context).liked(widget.postData);
    //BlocProvider.of<SavedCubit>(context).likecounter(widget.postData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool? issSaved;
    bool? issLaked;
    int? count;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          widget.postData['userId'] == currentUser
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      DeletePostDialog(context, widget.postData);
                    },
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      size: 34,
                      color: Colors.red,
                    ),
                  ),
                )
              : const SizedBox()
        ],
        elevation: 20,
        shadowColor: Colors.orange,
        title: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              widget.postData['categorie'] ?? '',
              style: const TextStyle(color: Colors.white),
            )),
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: BlocBuilder<SavedCubit, SavedState>(
        builder: (context, savedState) {
          if (savedState is Save) {
            issSaved = savedState.isSaved;
          }
          if (savedState is Like) {
            issLaked = savedState.isLiked;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 100, bottom: 10),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.postData['head'],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onDoubleTap: () {},
                    child: Container(
                      height: 300,
                      margin: const EdgeInsets.only(left: 12),
                      width: MediaQuery.of(context).size.width * 0.93,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 247, 209, 209)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: widget.postData['photo'] != null
                            ? Stack(
                                children: [
                                  Hero(
                                    tag: 'detailImage',
                                    child: Image(
                                      height: double.infinity,
                                      width: double.infinity,
                                      image: CachedNetworkImageProvider(
                                          widget.postData['photo']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return detailImage(context);
                                          }));
                                        },
                                        child: const Icon(
                                          Icons.image_search_outlined,
                                          size: 33,
                                          color: Colors.orange,
                                        ),
                                      ))
                                ],
                              )
                            : const Image(
                                image: AssetImage('assets/images/noImage.png')),
                      ),
                    ),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              profielOnOpen(data: widget.userData),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: CircleAvatar(
                          radius: 25,
                          foregroundImage: CachedNetworkImageProvider(widget
                                  .userData!['avatarImage'] ??
                              'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              profielOnOpen(data: widget.userData),
                        ));
                      },
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          widget.userData!['username'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    LikeButton(
                      isLiked: issLaked,

                      onTap: onLikeButtonTapped,
                      padding: const EdgeInsets.only(left: 5),
                      size: 33,
                      circleColor: const CircleColor(
                          start: Colors.yellow, end: Colors.orange),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.orange,
                        dotSecondaryColor: Colors.yellow,
                      ),
                      //  likeCount: count ?? 0,
                      likeCountPadding: const EdgeInsets.only(right: 10),
                      likeBuilder: (issLaked) {
                        return issLaked
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.orange,
                                size: 30,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 30,
                              );
                      },
                    ),
                    LikeButton(
                      padding: const EdgeInsets.only(left: 5),
                      size: 40,
                      isLiked: issSaved,
                      onTap: onBookMarkButtonTapped,
                      circleColor: const CircleColor(
                          start: Colors.brown, end: Colors.brown),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.white,
                        dotSecondaryColor: Color.fromARGB(255, 86, 61, 52),
                      ),
                      likeBuilder: (isSaved) {
                        return isSaved
                            ? const Icon(
                                Icons.bookmark_outlined,
                                color: Colors.brown,
                                size: 30,
                              )
                            : const Icon(
                                Icons.bookmark_border_outlined,
                                size: 30,
                              );
                      },
                    )
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.postData != null
                          ? StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('Recipes')
                                  .doc(widget.postData['id'])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return (snapshot.connectionState ==
                                        ConnectionState.waiting)
                                    ? const Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 20, bottom: 5),
                                          child: Text(''),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25, bottom: 5),
                                          child: Text(
                                            snapshot.data!['totalLikes'] != null
                                                ? 'total Likes: ${snapshot.data!['totalLikes'].length}'
                                                    .toString()
                                                : 'total Likes: 0',
                                            style: const TextStyle(
                                                color: Colors.orange),
                                          ),
                                        ),
                                      );
                              })
                          : const SizedBox(),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(7)),
                            height: 30,
                            width: 150,
                            child: Text(
                              "${widget.postData['serves'].toString()}  kishiga",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(7)),
                            height: 30,
                            width: 180,
                            child: Text(
                              'cookTime:  ${widget.postData['cookTime']}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'text:  ${widget.postData['text']}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                          'Ingredients',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                          height: 300,
                          child: widget.postData['items'] != null
                              ? (ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.postData['items'].length,
                                  itemBuilder: (context, index) {
                                    Map item = widget.postData['items'][index];
                                    List myList = item.values.toList();
                                    String itemName = myList[1];
                                    String itemQuant = myList[0];

                                    return Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.orangeAccent
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Text(
                                          "$itemName  $itemQuant  ",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    );
                                  },
                                ))
                              : const SizedBox())
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget detailImage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: Center(
            child: Hero(
                tag: 'detailImage',
                child: Stack(children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: Image(
                          image: CachedNetworkImageProvider(
                              widget.postData['photo']))),
                  Positioned(
                      top: 30,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.expand_circle_down,
                          size: 50,
                          color: Colors.orange,
                        ),
                      ))
                ]))),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<bool> onBookMarkButtonTapped(bool isSaved) async {
    if (isSaved == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          elevation: 100,
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 40, right: 20, left: 20),
          backgroundColor: Colors.orange,
          content: Row(
            children: [
              Image(
                  height: 30,
                  width: 30,
                  image: CachedNetworkImageProvider(
                    widget.postData['photo'],
                  )),
              const SizedBox(
                width: 20,
              ),
              Text(
                '${widget.postData['categorie'].toString()}  |saved|',
              ),
            ],
          )));
    }
    await FireDatabaseService.saved(widget.postData['id'], isSaved);
    return !isSaved;
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    await FireDatabaseService.like(widget.postData['id'], isLiked);

    return !isLiked;
  }
}
