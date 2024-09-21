import 'package:doc_app/core/di/dependency_injection.dart';
import 'package:doc_app/core/routing/routes.dart';
import 'package:doc_app/features/home/ui/home_screen.dart';
import 'package:doc_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doc_app/features/login/ui/login_screen.dart';
import 'package:doc_app/features/onboarding/onboarding_screen.dart';
import 'package:doc_app/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:doc_app/features/sign_up/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignUpScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
