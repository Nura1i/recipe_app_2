import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/like%20and%20saved/likedIcon_state.dart';

class LikedCubit extends Cubit<LikedState> {
  LikedCubit() : super(LikedInit());
  bool change = false;

  changeLike() {
    emit(LikedSuccess(change));
    change = !change;
    log(change.toString());
  }

  Widget Like(bool changed) {
    return changed == true
        ? const Icon(
            Icons.favorite,
            size: 33,
          )
        : const Icon(
            Icons.favorite_border,
            size: 33,
          );
  }

  get icLike => Like(change);
}
