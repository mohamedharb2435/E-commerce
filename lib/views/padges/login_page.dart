import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
 const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController= TextEditingController();
  final _passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32,vertical:64),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login",
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 64,),
                TextFormField(
                  validator: (val)=> val!.isEmpty?'please enter your email!':null,
                  controller: _emailController,
                  decoration:const  InputDecoration(
                    labelText:"Email",
                    hintText: "Enter Email",
                  ),
                ),
                const SizedBox(height: 24,),
                  TextFormField(
                    validator: (val)=>val!.isEmpty?'please enter your password!':null,
                    controller: _passwordController,
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
                    onPressed: (){},
                    text: 'Login'
                ),
                const SizedBox(height: 16,),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child:const Text('Don\'t have an account? Register ',
                    ),
                    onTap: () => Navigator.of(context).pushNamed('register'),
                  ),
                ),
                const Spacer(),
                const Align(
                  alignment: Alignment.center,
                  child: Text('Or Login With'),
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
      )
    );

  }
}
