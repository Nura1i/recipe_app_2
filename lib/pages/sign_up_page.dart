import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/blocs/login/sign_up_state.dart';
import 'package:recipe_app/views/sign_up_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          if (state is passwordCheck) {
            passwordObs = state.pass;
          }
          if (state is alreadyHasAccount) {
            result = state.result;
            log('${result.toString()}  result');
          }
          if (state is SignUpLoading) {
            load = state.load;
            log(load.toString());
          }

          return signUpView(context, result, load, passwordObs);
        },
      ),
    );
  }
}

bool result = false;
bool load = false;
bool passwordObs = true;
bool chek = false;
