import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInit extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  final bool? isRegistered;

  SignUpLoaded({this.isRegistered});
}

class SignUpError extends SignUpState {
  final error;
  SignUpError({this.error});
}
