import 'dart:developer';

import 'package:adminpanel/modules/login/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/admin/admin_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  AdminModel loginModel;

  bool isEnglish = CacheHelper.getData(key: 'lang') == 'en'? true : false;

  Future<void> adminLogin({
    @required context,
    @required String email,
    @required String password,
  }) async {
    emit(ShopLoginLoadingState());
    await FirebaseFirestore.instance.disableNetwork();
    await FirebaseFirestore.instance.enableNetwork();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          log(value.user.uid);
      // await CacheHelper.saveData(key: 'UID', value: value.user?.uid);
      FirebaseFirestore.instance
          .collection('admins')
          .where('email', isEqualTo: email)
          .get()
          .then((value) async {
        loginModel = AdminModel.fromJson(value.docs[0].data());
        emit(ShopLoginSuccessState(loginModel));
      }).catchError((error) {
        log(error.toString());
        emit(ShopLoginErrorState((error.toString())));
      });
    }).catchError((error) {
      log(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  Future<void> resetPassword(email) async {
    emit(ResetPasswordLoadingState());
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((
        value) {
      showToast(text: 'The email has been sent', state: ToastStates.success);
      emit(ResetPasswordSuccessState());
    }).catchError((err) {
      log(err.toString());
      showToast(text: 'Error when sending Email', state: ToastStates.error);
      emit(ResetPasswordErrorState());
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }

  changeLanguageValue(v, context) async {
    isEnglish = v;
    log(isEnglish.toString());
    CacheHelper.saveData(key: 'lang', value: isEnglish);
    emit(AppChangeLanguageState());
  }
}
