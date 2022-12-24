import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/like%20and%20saved/savedIcon_state.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedInit());
  bool changed = false;

  changeBoomark() {
    emit(SavedSuccess(changed));
    changed = !changed;
    print(changed);
  }

  Widget bookmark(bool changed) {
    return changed == true
        ? const Icon(
            Icons.bookmark,
            size: 33,
          )
        : const Icon(
            Icons.bookmark_border_outlined,
            size: 33,
          );
  }

  get icBook => bookmark(changed);
}
