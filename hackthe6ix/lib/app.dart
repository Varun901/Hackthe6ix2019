import 'package:flutter/material.dart';
import 'package:hackthe6ix/home.dart';
import 'package:hackthe6ix/not_found.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      onGenerateRoute: (routeSettings) {
        final name = routeSettings.name;
        if (name == '/home')
          return MaterialPageRoute(builder: (context) => Home());
        return MaterialPageRoute(builder: (contxt) => NotFound());
      },
    );
  }
}
