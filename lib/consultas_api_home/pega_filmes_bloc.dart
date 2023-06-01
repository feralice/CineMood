
import 'package:rxdart/rxdart.dart';
import '../constantes/constants.dart';
import '../telas_para_cada_botao_do_navigation/Home/modelos/movie_resposta.dart';

class MoviesListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}
final moviesBloc = MoviesListBloc();