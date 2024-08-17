import 'package:e_commerce/utilities/routes.dart';
import 'package:e_commerce/views/padges/register_page.dart';
import 'package:flutter/cupertino.dart';

import '../views/padges/landing_page.dart';
import '../views/padges/login_page.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.registerPageRoute:
      return CupertinoPageRoute(builder: (_)=> const RegisterPage(),);
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(builder: (_)=> const LoginPage(),);
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(builder: (_) => const LandingPage());
  }
}
