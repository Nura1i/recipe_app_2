abstract class CameraState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CameraInit extends CameraState {}

class CameraOpen extends CameraState {
  final cameraOpen;
  CameraOpen(this.cameraOpen);
}

class imagePick extends CameraState {
  final imagepick;
  imagePick(this.imagepick);
}

class choose extends CameraState {
  final choosed;
  choose(this.choosed);
}

class AcceptCount extends CameraState {
  final accept;
  AcceptCount(this.accept);
}

class AcceptTime extends CameraState {
  final acceptTime;
  AcceptTime(this.acceptTime);
}

class addItemState extends CameraState {
  final items;

  addItemState(this.items);
}

class postedRecipe extends CameraState {
  final listOfRecipes;
  postedRecipe(this.listOfRecipes);
}

class loadingg extends CameraState {
  final load;
  loadingg(this.load);
}

class successPost extends CameraState {
  final isPosted;
  successPost(this.isPosted);
}
