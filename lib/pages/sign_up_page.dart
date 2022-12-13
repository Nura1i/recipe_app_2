import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/blocs/login/sign_up_state.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/views/sign_up_view.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _loginPageState();
}

class _loginPageState extends State<signUpPage> {
  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
      BlocProvider.of<SignUpCubit>(context).signUp;
    }

    return Scaffold(
      body: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (BuildContext context, SignUpState state) {
          if (state is SignUpError) {
            return const Text('Error');
          }

          if (state is SignUpLoaded) {
            //  var items = state.posts!;
            var nmadr = state.isRegistered;
            return const HomePage();
          }

          return viewOfLoading();
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
