import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static final GetStorage _appBox = GetStorage();

  static Future<void> init() async => await GetStorage.init();

  static Future<void> cacheUserInfo({required String userName}) async {
    await _appBox.write('userName', userName);
  }

  static String? get getUserName {
    String? userName;
    if (_appBox.hasData('userName')) {
      userName = _appBox.read('userName');
    }
    return userName;
  }

//===============================================================

  static Future<void> cacheTheme({required bool? value}) async {
    await _appBox.write('isDark', value);
  }

  static Future<bool?> get getTheme async {
    bool? isDark;
    if (_appBox.hasData('isDark')) {
      isDark = _appBox.read('isDark');
    }
    return isDark;
  }

//===============================================================

  static Future<void> cacheSound({required bool? value}) async {
    await _appBox.write('isSoundOn', value);
  }

  static Future<bool?> get getSound async {
    bool? isSoundOn;
    if (_appBox.hasData('isSoundOn')) {
      isSoundOn = _appBox.read('isSoundOn');
    }
    return isSoundOn;
  }

//===============================================================

  static Future<void> cacheShowCase({required bool? value}) async {
    await _appBox.write('isFirstTime', value);
  }

  static Future<bool?> get getShowCase async {
    bool? isFirstTime;
    if (_appBox.hasData('isFirstTime')) {
      isFirstTime = _appBox.read('isFirstTime');
    }
    return isFirstTime;
  }

//===============================================================
  static Future<void> saveData(
      {required String key, required dynamic value}) async {
    return await _appBox.write(key, value);
  }

  static dynamic get({required String key}) {
    return _appBox.read(key);
  }
}
