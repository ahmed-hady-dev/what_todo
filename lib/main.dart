import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view/home/controller/home_cubit.dart';
import 'view/home/home_view.dart';

import 'core/blocObserver/bloc_observer.dart';
import 'core/cacheHelper/cache_helper.dart';
import 'core/dioHelper/dio_helper.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //===============================================================
  DioHelper.init();
  //===============================================================
  await EasyLocalization.ensureInitialized();
  //===============================================================
  await CacheHelper.init();
  await CacheHelper.getTheme ?? await CacheHelper.cacheTheme(value: false);
  await CacheHelper.getSound ?? await CacheHelper.cacheSound(value: true);
  await CacheHelper.getShowCase ?? await CacheHelper.cacheShowCase(value: true);
  bool? isDark = await CacheHelper.getTheme;
  bool? isSoundOn = await CacheHelper.getSound;
  bool? isFirstTime = await CacheHelper.getShowCase;
  HomeCubit().showCase(isFirstTime: isFirstTime);
  //===============================================================
  BlocOverrides.runZoned(
    () {
      runApp(EasyLocalization(
        child: MyApp(isDark: isDark!, isSoundOn: isSoundOn!),
        path: 'assets/translation',
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
        fallbackLocale: const Locale('en', 'US'),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isDark, this.isSoundOn}) : super(key: key);
  final bool? isDark;
  final bool? isSoundOn;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              ThemeCubit()..changeTheme(themeModeFromCache: isDark),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              HomeCubit()..changeSound(soundFromCache: isSoundOn),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          var themeCubit = ThemeCubit.get(context).isDark;
          return MaterialApp(
            title: 'What todo',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            onGenerateRoute: onGenerateRoute,
            themeMode: themeCubit ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme(context),
            darkTheme: darkTheme(context),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}
