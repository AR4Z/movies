import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '4c5d3064bb461100f9a5ce4245bd25c1';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>>getEnCines() async {
    final url = Uri.https(this._url, '3/movie/now_playing',  {
      'api_key' : this._apikey,
      'language': this._language
    });

    return _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(this._url, '3/movie/popular', {
      'api_key' : this._apikey,
      'language': this._language
    });
    return _procesarRespuesta(url);


  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }
}