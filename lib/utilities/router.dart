import 'package:e_commerce/utilities/routes.dart';
import 'package:flutter/cupertino.dart';

import '../views/padges/landing_page.dart';
import '../views/padges/auth_page.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {

    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(builder: (_)=> const AuthPage(),);
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(builder: (_) => const LandingPage());
  }
}
