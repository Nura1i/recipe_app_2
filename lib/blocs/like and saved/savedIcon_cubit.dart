import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_state.dart';
import 'package:recipe_app/consts/consts.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedInit());

  saved(data) async {
    bool isSaved = false;
    List savedLs = [];
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get();

    savedLs = userDoc.get('saved') ?? [];

    if (savedLs.contains(data['id'])) {
      isSaved = true;
    }
    emit(Save(isSaved));
  }

  liked(data) async {
    int count = 0;
    bool isLiked = false;
    List likedLs = [];

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Recipes')
        .doc(data['id'])
        .get();

    likedLs = userDoc.get('totalLikes') ?? [];
    count = likedLs.length;
    if (likedLs.contains(currentUser)) {
      isLiked = true;
    }

    emit(Like(isLiked));
  }

  // likecounter(data) async {
  //   List lsUserId;
  //   int count;
  //   DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //       .collection('Recipes')
  //       .doc(data['id'])
  //       .get();
  //   lsUserId = userDoc.get('totalLikes') ?? [];
  //   count = lsUserId.length;
  //   log(lsUserId.toString());
  //   log(count.toString());
  //   emit(counterLike(count));
  // }
}
