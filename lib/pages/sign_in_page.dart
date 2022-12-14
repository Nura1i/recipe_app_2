import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/login/sign_in_cubit.dart';
import 'package:recipe_app/blocs/login/sign_in_state.dart';
import 'package:recipe_app/views/sign_in_view.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SignInCubit>(context).signIn(context);

    return Scaffold(
      body: BlocBuilder<SignInCubit, SignInState>(
        builder: (BuildContext context, SignInState state) {
          if (state is SignInError) {
            return viewOfError(state.error);
          }
          return const SignInView();
        },
      ),
    );
  }

  Widget viewOfError(String err) {
    return Center(
      child: Text("Error occurred $err"),
    );
  }

  Widget viewOfLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
