class Movie {
  final int id;
  final num popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final num rating;

  Movie(this.id,
      this.popularity,
      this.title,
      this.backPoster,
      this.poster,
      this.overview,
      this.rating);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"] ?? 0,
        title = json["title"] ?? "",
        backPoster = json["backdrop_path"] ?? "",
        poster = json["poster_path"] ?? "",
        overview = json["overview"] ?? "",
        rating = json["vote_average"] ?? 0.0;

}