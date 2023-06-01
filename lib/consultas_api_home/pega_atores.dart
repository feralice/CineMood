
import 'package:rxdart/rxdart.dart';
import '../constantes/constants.dart';
import '../telas_para_cada_botao_do_navigation/Home/modelos/pessoa_resposta.dart';

class PersonsListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
  BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repository.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;

}
final personsBloc = PersonsListBloc();