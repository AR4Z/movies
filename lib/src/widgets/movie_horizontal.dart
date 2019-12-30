import 'package:flutter/material.dart';
import 'package:movies/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController =
      new PageController(viewportFraction: 0.3, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
        height: _screenSize.height * 0.3,
        child: PageView.builder(
          pageSnapping: false,
          //children: _tarjetas(context),
          itemBuilder: (BuildContext context, int index) {
            return _tarjeta(context, this.peliculas[index]);
          },
          controller: _pageController,
          itemCount: this.peliculas.length,
        ));
  }

  Widget _tarjeta(BuildContext context, Pelicula movie) {
    movie.uniqueId = '${movie.id}-poster';
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'detalle', arguments: movie);
      }
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(movie.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption),
          ],
        ),
      );
    }).toList();
  }
}
