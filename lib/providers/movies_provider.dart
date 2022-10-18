import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/Models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'df1dda9166c6b4943e7b5b41afee743d';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  MoviesProvider() {
    print('Movies provider');
    getOnDisplayMovies();
  }
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    print(nowPlayingResponse.results.first.title);
  }
}
