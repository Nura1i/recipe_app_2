import 'dart:developer';

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

bool check = true;
bool userResult = false;
bool loadingProgres = false;

class _SignInPage extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignInCubit, SignInState>(
        builder: (BuildContext context, SignInState state) {
          if (state is SignInError) {
            return viewOfError(state.error);
          }

          if (state is PassState) {
            check = state.pass;
          }

          if (state is SignInUserNotFound) {
            log('${userResult.toString()} state');
            userResult = state.result;
          }

          return SignInView(
            context: context,
            pass: check,
            UserResult: userResult,
          );
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
