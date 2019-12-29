import 'package:flutter/material.dart';

import 'package:movies/src/home_page.dart';
import 'package:movies/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/': ( BuildContext context ) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}



