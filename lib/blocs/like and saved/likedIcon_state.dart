abstract class LikedState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LikedInit extends LikedState {}

class LikedSuccess extends LikedState {
  final success;
  LikedSuccess(this.success);
}
