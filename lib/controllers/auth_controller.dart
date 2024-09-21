import 'package:e_commerce/models/users.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/utilities/constant.dart';
import 'package:e_commerce/utilities/enum.dart';
import 'package:flutter/cupertino.dart';

import 'database_controller.dart';

class AuthController with ChangeNotifier {
  String email;
  String password;
  final AuthBase auth;
  AuthFormType authFormType;
  final database = FirestoreDatabase('1233');
  AuthController({
    required this.auth,
    this.authFormType = AuthFormType.login,
    this.email = '',
    this.password = '',
  });
  void toggleFormType() {
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    copyWith(
      email: '',
      password: '',
      authFormType: formType,
    );
  }

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
       final user = await auth.signupWithEmailAndPassword(email, password);
        await database.setUserData(
          UserData(
            uid:user?.uid?? documentIdFromLocalData(),
            email: email,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void updateEmail(String email) => copyWith(email: email);
  void updatePassword(String password) => copyWith(password: password);
  void copyWith({
    String? email,
    String? password,
    AuthFormType? authFormType,
  }) {
    this.authFormType = authFormType ?? this.authFormType;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await auth.logOut();
    } catch (e) {
      rethrow;
    }
  }
}
