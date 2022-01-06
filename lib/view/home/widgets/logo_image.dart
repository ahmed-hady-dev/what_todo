// ignore_for_file: implementation_imports, avoid_print

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:what_todo/core/cacheHelper/cache_helper.dart';
import 'package:what_todo/core/responsive_helper/responsive_layout.dart';
import 'package:what_todo/core/theme/theme_cubit.dart';
import 'package:what_todo/view/home/controller/home_cubit.dart';
import 'package:what_todo/view/home/widgets/settings_model_sheet.dart';

class LogoImage extends StatefulWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoImage> createState() => _LogoImageState();
}

class _LogoImageState extends State<LogoImage>
    with SingleTickerProviderStateMixin {
  final _defaultDuration = const Duration(
    seconds: 2,
  );
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: _defaultDuration)
        ..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
          begin: const Offset(0, 0.13), end: Offset.zero)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  late final Animation<double> _breathingAnimation = Tween<double>(
          begin: 30, end: 20)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback(
    //   (_) => ShowCaseWidget.of(context)!.startShowCase(
    //     [
    //       Constant.logoKey,
    //       Constant.nameKey,
    //       Constant.taskKey,
    //       Constant.homeFabKey,
    //     ],
    //   ),
    // );

    // print('Constant.logoKey  ' + Constant.logoKey.currentWidget.toString());
    // print('Constant.descriptionKey  ' +
    //     Constant.descriptionKey.currentWidget.toString());
    // print(
    //     'Constant.homeFabKey  ' + Constant.homeFabKey.currentWidget.toString());
    // print('Constant.nameKey  ' + Constant.nameKey.currentWidget.toString());
    // print(
    //     'Constant.taskFabKey  ' + Constant.taskFabKey.currentWidget.toString());
    // print('Constant.taskKey  ' + Constant.taskKey.currentWidget.toString());
    // print('Constant.titleKey  ' + Constant.titleKey.currentWidget.toString());
    // print(
    //     'Constant.todoAddKey  ' + Constant.todoAddKey.currentWidget.toString());
    // print('Constant.todoCheckKey  ' +
    //     Constant.todoCheckKey.currentWidget.toString());
    // print('Constant.todoDeleteKey  ' +
    //     Constant.todoDeleteKey.currentWidget.toString());
    // if (Constant.isFirst) {
    //   WidgetsBinding.instance!.addPostFrameCallback(
    //     (_) => ShowCaseWidget.of(context)!.startShowCase(
    //       [
    //         Constant.logoKey,
    //         Constant.nameKey,
    //         Constant.taskKey,
    //         Constant.homeFabKey,
    //       ],
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var userName = CacheHelper.getUserName ?? '';
    final widgetList = <Widget>[
      InkWell(
        onTap: showSettingsModalBottomSheet,
        child: Row(
          children: [
            const SizedBox(width: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 22.0),
                SlideTransition(
                  position: _animation,
                  transformHitTests: false,
                  child: Image.asset('assets/images/three_dots.png',
                      width: isLandscape
                          ? MediaQuery.of(context).size.height * 0.25
                          : MediaQuery.of(context).size.width * 0.2),
                ),
                AnimatedBuilder(
                  animation: _breathingAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsetsDirectional.only(
                          top: 22.0, bottom: 22.0, start: 0.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0,
                        child: Container(
                          height: _breathingAnimation.value - 10,
                          width: _breathingAnimation.value + 36,
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: ThemeCubit.get(context).isDark
                                ? Colors.white38
                                : Colors.black26,
                            borderRadius: const BorderRadius.all(
                                Radius.elliptical(180, 50)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      isLandscape
          ? const SizedBox()
          : Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('hello'.tr(),
                        style: Theme.of(context).textTheme.headline5),
                    Expanded(
                      child: SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: context.locale.languageCode == 'en'
                                  ? 0.0
                                  : 5.0),
                          child: TextField(
                            textAlign: TextAlign.start,
                            controller: HomeCubit.get(context).nameController
                              ..text = userName,
                            style: Theme.of(context).textTheme.headline5,
                            decoration: InputDecoration(
                                hintText: 'enter_name'.tr(),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.6))),
                            onSubmitted: (value) {
                              CacheHelper.cacheUserInfo(userName: value);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
    ];
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ResponsiveLayout(
          mobilePortrait: Row(children: widgetList),
          mobileLandscape: Column(
            children: widgetList,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          )),
    );
  }

  Future<dynamic> showSettingsModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (context) {
        return const SettingModalSheet();
      },
    );
  }
}
