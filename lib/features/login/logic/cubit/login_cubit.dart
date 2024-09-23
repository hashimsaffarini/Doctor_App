import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:doc_app/core/networking/dio_factory.dart';
import 'package:doc_app/features/login/data/models/login_request_body.dart';
import 'package:doc_app/features/login/data/repos/login_repo.dart';
import 'package:doc_app/features/login/logic/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginState(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(loginRequestBody);
    response.when(success: (loginResponse) async {
      await saveUserToekn(loginResponse.userData?.token ?? '');

      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.failure(error: error.apiErrorModel.message ?? ""));
    });
  }

  Future<void> saveUserToekn(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
