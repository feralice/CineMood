import 'filme_detalhes.dart';

class MovieDetailResponse {
  final MovieDetail movieDetail;
  final String error;

  MovieDetailResponse(this.movieDetail, this.error);

  MovieDetailResponse.fromJson(Map<String, dynamic> json)
      : movieDetail = MovieDetail.fromJson(json),
        error = "";

  MovieDetailResponse.withError(String errorValue)
      : movieDetail = MovieDetail.empty,
        error = errorValue;
}