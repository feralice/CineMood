import 'package:rxdart/rxdart.dart';
import '../constantes/constants.dart';
import '../telas_para_cada_botao_do_navigation/Home/modelos/genero_resposta.dart';

class GenresListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<GenreResponse> _subject =
  BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _repository.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;

}
final genresBloc = GenresListBloc();