abstract class blockState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class blockInit extends blockState {}

class blockRecipe extends blockState {
  final data;
  blockRecipe(this.data);
}
