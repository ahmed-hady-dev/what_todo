import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../cacheHelper/cache_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeChangeState());
  static ThemeCubit get(context) => BlocProvider.of(context);
//===============================================================
  bool isDark = false;
  void changeTheme({bool? themeModeFromCache}) async {
    if (themeModeFromCache != null) {
      isDark = themeModeFromCache;
      emit(ThemeChangeState());
    } else {
      isDark = !isDark;
      await CacheHelper.saveData(key: 'isDark', value: isDark);
      emit(ThemeChangeState());
    }
  }
//===============================================================
}
