import 'package:ecommmerce_app/core/navigator/generate_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/viewmodels/CRUDModelOfCart.dart';
import 'core/viewmodels/CRUDModelOfProduct.dart';
import 'core/viewmodels/my_provider.dart';
import 'locator.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<CRUDModelOfProduct>()),
        ChangeNotifierProvider(create: (_) => locator<CRUDModelOfCart>()),
        ChangeNotifierProvider(create: (_) => locator<MyProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Color(0xFFFF1E00),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        initialRoute: "/",
        onGenerateRoute: GenerateRoute.onGenerateRoute,
      ),
    );
  }
}
