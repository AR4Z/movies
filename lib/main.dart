import 'package:flutter/material.dart';

import 'package:movies/src/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/': ( BuildContext context ) => HomePage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}



