import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/actores_model.dart';

import 'package:movies/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '4c5d3064bb461100f9a5ce4245bd25c1';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;
  void dispose() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>>getEnCines() async {
    final url = Uri.https(this._url, '3/movie/now_playing',  {
      'api_key' : this._apikey,
      'language': this._language
    });

    return _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {
    if(_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(this._url, '3/movie/popular', {
      'api_key' : this._apikey,
      'language': this._language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);

    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Actor>>getCast(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/credits',{
      'api_key' : this._apikey,
      'language': this._language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(this._url, '3/search/movie',  {
      'api_key' : this._apikey,
      'language': this._language,
      'query': query
    });

    return _procesarRespuesta(url);

  }
}