import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';
import 'package:fitme_admin_app/screens/CoachScreen/coach_view.dart';

class CoachPresenter {
  CoachView _coachView;
  late CoachRepository _coachRepository;

  CoachPresenter(this._coachView) {
    _coachRepository = new Injector().coachRepository;
  }

  void loadAllCoaches() async {
    try {
      List<Coach> listCoaches = await _coachRepository.getAllCoaches();
      _coachView.loadCoaches(listCoaches);
    } catch (e) {
      _coachView.showEmptyList();
      print(e);
    }
  }

  void deleteCoach(int id) async {
    try {
      await _coachRepository.disableCoach(id);
      _coachView.refresh();
    } catch (e) {
      print(e);
    }
  }
}
