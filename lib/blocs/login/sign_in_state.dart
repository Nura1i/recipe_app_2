abstract class SignInState {
  @override
  List<Object> get props => [];
}

class SignInInit extends SignInState {}

class SignInLoading extends SignInState {
  final loading;
  SignInLoading({this.loading});
}

class SignInLoaded extends SignInState {
  final bool? isSaved;

  SignInLoaded({this.isSaved});
}

class PassState extends SignInState {
  final pass;
  PassState({this.pass});
}

class SignInError extends SignInState {
  final error;
  SignInError({this.error});
}

class SignInUserNotFound extends SignInState {
  final result;
  SignInUserNotFound({this.result});
}
