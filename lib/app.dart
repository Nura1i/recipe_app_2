import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/login/sign_up_cubit.dart';
import 'package:recipe_app/utils/theme/themes.dart';
import 'package:recipe_app/views/sign_up_view.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: AppTheme.whiteTheme,
        initial: AppTheme.currentSavedTheme ?? AdaptiveThemeMode.dark,
        builder: (light, dark) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //  home: const signUpPage()
            // HomePage()
            // home: signUpView()

            home: MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => SignUpCubit(),
              )
            ], child: const signUpView())));
  }
}
