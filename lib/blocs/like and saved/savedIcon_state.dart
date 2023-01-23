abstract class SavedState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SavedInit extends SavedState {}

class SavedSuccess extends SavedState {
  final success;
  SavedSuccess(this.success);
}

class Save extends SavedState {
  final isSaved;

  Save(this.isSaved);
}

class Like extends SavedState {
  final isLiked;
  Like(this.isLiked);
}

class counterLike extends SavedState {
  final count;
  counterLike(this.count);
}
