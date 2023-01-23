import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/search%20Page/searchState.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInit());

  userSearch(user) {
    emit(searched(user));
  }
}
