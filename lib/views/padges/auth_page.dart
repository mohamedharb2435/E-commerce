import 'package:e_commerce/utilities/enum.dart';
import 'package:e_commerce/utilities/routes.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthPage extends StatefulWidget {
 const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();

}

class _AuthPageState extends State<AuthPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController= TextEditingController();
  final _passwordController= TextEditingController();
  final _emailFocusNode=FocusNode();
  final _passwordFocusNode=FocusNode();
  var _authType = authFormType.login;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32,vertical:64),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _authType == authFormType.login ?"Login": 'Register',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 64,),
                  TextFormField(
                    validator: (val)=> val!.isEmpty?'please enter your email!':null,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(_passwordFocusNode),
                    decoration:const  InputDecoration(
                      labelText:"Email",
                      hintText: "Enter Email",
                    ),
                  ),
                  const SizedBox(height: 24,),
                    TextFormField(
                      validator: (val)=>val!.isEmpty?'please enter your password!':null,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      decoration:const  InputDecoration(
                        labelText:"Password",
                        hintText: "Enter Password",
                      ),
                  ),
                  const SizedBox(height: 24,),
                   Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child:const Text('Forgot Your Password?',
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 24,),
                  MainButton(
                      onPressed: (){
                        if(_formkey.currentState!.validate()){
                          Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
                        }
                      },
                      text: _authType == authFormType.login ?'Login':'Register',
                  ),
                  const SizedBox(height: 16,),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        _authType == authFormType.login ?
                        'Don\'t have an account? Register ':'Have an Account? Login',
                      ),
                      onTap: () {
                       setState(() {
                         _formkey.currentState!.reset();
                         if(_authType==authFormType.login){
                           _authType= authFormType.register;
                         }else {
                           _authType = authFormType.login;
                         }
                       });
                      },
                    ),
                  ),
                   SizedBox(height: size.height*(.07),),
                   Align(
                    alignment: Alignment.center,
                    child: Text(
                        _authType == authFormType.login ?'Or Login With':'Or Register With',
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child:const  Icon(Icons.add),
                      ),
                      const SizedBox(width: 16,),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child:const  Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );

  }
}
