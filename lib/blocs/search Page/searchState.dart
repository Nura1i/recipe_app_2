abstract class SearchState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchInit extends SearchState {}

class searched extends SearchState {
  final user;
  searched(this.user);
}
