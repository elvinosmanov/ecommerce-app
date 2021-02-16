import 'package:ecommmerce_app/ui/screens/cart_page.dart';
import 'package:ecommmerce_app/ui/screens/home_page.dart';
import 'package:ecommmerce_app/ui/screens/landing_page.dart';
import 'package:ecommmerce_app/ui/screens/login_page.dart';
import 'package:ecommmerce_app/ui/screens/product_page.dart';
import 'package:ecommmerce_app/ui/screens/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenerateRoute {
  static const landingPageRoute = '/';
  static const homePageRoute = '/home';
  static const cartPageRoute = '/cart';
  static const loginPageRoute = '/login';
  static const registerPageRoute = '/register';
  static const productPageRoute = '/product';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingPageRoute:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case cartPageRoute:
        return MaterialPageRoute(builder: (_) => CartPage());
      case homePageRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case loginPageRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerPageRoute:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case productPageRoute:
        return MaterialPageRoute(builder: (_) => ProductPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("Page not found"),
              ),
            ));
  }
}
