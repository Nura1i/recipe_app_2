import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInit extends SignUpState {}

class SignUpLoading extends SignUpState {
  final load;
  SignUpLoading({this.load});
}

class SignUpLoaded extends SignUpState {}

class alreadyHasAccount extends SignUpState {
  final result;
  alreadyHasAccount({this.result});
}

class SignUpError extends SignUpState {
  final error;
  SignUpError({this.error});

}
