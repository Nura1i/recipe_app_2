import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/card%20block/list_post_state.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';
import 'package:recipe_app/repositories/services/http_service.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit() : super(ListPostInit());

  void apiPostList() async {
    final top = await FireDatabaseService.topCreators();
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      emit(ListPostLoaded(posts: Network.parsePostList(response), result: top));
    } else {
      emit(ListPostError(error: "Couldn't fetch posts"));
    }
  }

  void runner() {
    FireDatabaseService.getdata();
  }

  var topData;
  TopgetUser(userID) async {
    var ref = FirebaseFirestore.instance.collection('users').doc(userID);
    topData = await ref.get();
    log(topData['username'].toString());
    // ignore: void_checks
  }

  topUserr(userID) async {
    DocumentSnapshot recipeDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    final data = recipeDoc.data();
    emit(TopUserData(data));
  }
}
