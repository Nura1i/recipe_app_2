abstract class SignUpState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpInit extends SignUpState {}

class SignUpLoading extends SignUpState {
  final load;
  SignUpLoading(this.load);
}

class passwordCheck extends SignUpState {
  final pass;
  passwordCheck(this.pass);
}

class SignUpLoaded extends SignUpState {}

class SignUpError extends SignUpState {
  final error;
  SignUpError({this.error});
}

class alreadyHasAccount extends SignUpState {
  final result;
  alreadyHasAccount(this.result);
}
