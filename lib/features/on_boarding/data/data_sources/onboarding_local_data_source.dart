import 'package:education_app/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSource {
  Future<void> cacheFirstTimer();
  Future<bool> isUserFirstTimer();
}

const kFirstTimerKey = 'first_timer';

class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  const OnBoardingLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;
  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> isUserFirstTimer() async {
    // TODO: implement isUserFirstTimer
    throw UnimplementedError();
  }
}
