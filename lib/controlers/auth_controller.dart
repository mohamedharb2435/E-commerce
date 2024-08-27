import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/utilities/enum.dart';
import 'package:flutter/cupertino.dart';

class AuthController with ChangeNotifier {
  String email ;
  String password;
  final AuthBase auth ;
  AuthFormType  authFormType;
  AuthController({
    required this.auth,
    this.authFormType = AuthFormType.login,
    this.email='',
    this.password= '',
});
  void toggleFormType(){
    final formType=authFormType ==AuthFormType.login
        ?AuthFormType.register
        :AuthFormType.login;
    copyWith(
      email: '',
      password: '',
      authFormType: formType,
    );
  }
  Future<void> submit()async{
    try{
      if(authFormType==AuthFormType.login){
        await auth.loginWithEmailAndPassword(email, password);
      }else{
        await auth.signupWithEmailAndPassword(email, password);
      }
    }catch(e){
      rethrow;
    }
  }
  void updateEmail(String email) => copyWith(email:email);
  void updatePassword(String password) => copyWith(password: password);
  void copyWith({
    String? email ,
    String? password,
    AuthFormType?  authFormType,
}){
    this.authFormType= authFormType ?? this.authFormType;
    this.email= email ?? this.email;
    this.password =password??this.password;
    notifyListeners();
  }
}