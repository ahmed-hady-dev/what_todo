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
  await CacheHelper.get(key: 'isDark') ??
      await CacheHelper.saveData(key: 'isDark', value: false);
  bool? isDark = CacheHelper.get(key: 'isDark');
  //===============================================================
  BlocOverrides.runZoned(
    () {
      runApp(EasyLocalization(
        child: MyApp(isDark: isDark!),
        path: 'assets/translation',
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
        fallbackLocale: const Locale('en', 'US'),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isDark}) : super(key: key);
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ThemeCubit()..changeTheme(themeModeFromCache: isDark),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
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
