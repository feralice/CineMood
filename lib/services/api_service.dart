import 'dart:convert';

import 'package:cinemood/constantes/constants.dart';
import 'package:cinemood/model/movie_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
enum MovieType { nowPlaying, popular, topRated, upcoming }

class ApiService {
  Future<List<MovieModel>> getMovieData(MovieType type) async {
    String url = "";

    if (type == MovieType.nowPlaying) {
      url = kmovieDbURL + know_playing;
    } else if (type == MovieType.popular) {
      url = kmovieDbURL + kpopular;
    } else if (type == MovieType.topRated) {
      url = kmovieDbURL + ktop_rated;
    } else if (type == MovieType.upcoming) {
      url = kmovieDbURL + kupcoming;
    }

    try {
      Response response = await get(Uri.parse(
          url + "?api_key=edd5884041916ec57223def708862cc8&language=pt-BR"));

      if(response.statusCode == 200) {

        Map<String,dynamic>json = jsonDecode(response.body);
        List<dynamic>body = json['results'];

        List<MovieModel> movielist = body.map((item) => MovieModel.fromJson(item)).toList();

        return movielist;

      } else {

        throw("Nenhum filme encontrado");

      }
    } catch (e) {
      throw e.toString();
    }
  }
}
