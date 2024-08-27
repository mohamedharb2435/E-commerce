import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/views/padges/auth_page.dart';
import 'package:e_commerce/views/padges/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if(user == null) {
             return const AuthPage();
            }else{
              return const HomePage();
        }
    return Scaffold(
    body: Center(
    child: CircularProgressIndicator(),
    ),
    );
  }
          );
  }
}
