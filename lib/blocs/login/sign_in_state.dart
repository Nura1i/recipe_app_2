import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInit extends SignInState {}

class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {
  final bool? isSaved;

  SignInLoaded({this.isSaved});
}

class SignInError extends SignInState {
  final error;
  SignInError({this.error});
}
