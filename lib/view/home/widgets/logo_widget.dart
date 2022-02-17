// ignore_for_file: implementation_imports, avoid_print

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:what_todo/constants/constants.dart';
import 'package:what_todo/core/cacheHelper/cache_helper.dart';
import 'package:what_todo/core/responsive_helper/responsive_layout.dart';
import 'package:what_todo/core/theme/theme_cubit.dart';
import 'package:what_todo/view/home/controller/home_cubit.dart';
import 'package:what_todo/view/home/widgets/settings_model_sheet.dart';
import 'package:what_todo/widgets/name_dialog.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget>
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
    if (CacheHelper.read(key: 'isFirstTime')) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => showDialog(
          context: context,
          builder: (context) => const NameDialog(),
        ).then((value) {
          final portraitList = <GlobalKey<State<StatefulWidget>>>[
            Constant.logoKey,
            Constant.nameKey,
            Constant.taskKey,
          ];
          final landscapeList = <GlobalKey<State<StatefulWidget>>>[
            Constant.logoKey,
            Constant.taskKey,
          ];
          ShowCaseWidget.of(context)!.startShowCase(
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? landscapeList
                  : portraitList);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var userName = CacheHelper.getUserName ?? '';
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final textStyle =
        Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white);
    final isEn = context.locale.languageCode == 'en';
    final space = isEn ? ' ' : '';
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
                Showcase(
                  key: Constant.logoKey,
                  description: 'showcase_logo'.tr(),
                  radius: BorderRadius.circular(18.0),
                  showcaseBackgroundColor: const Color(0xFF7349FE),
                  descTextStyle: textStyle,
                  overlayPadding: EdgeInsets.only(
                      bottom: isLandscape ? width * 0.04 : height * 0.04),
                  child: SlideTransition(
                    position: _animation,
                    transformHitTests: false,
                    child: Image.asset('assets/images/three_dots.png',
                        width: isLandscape ? height * 0.25 : width * 0.2),
                  ),
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
                child: Showcase(
                  key: Constant.nameKey,
                  description: 'showcase_name'.tr(),
                  radius: BorderRadius.circular(8.0),
                  showcaseBackgroundColor: const Color(0xFF7349FE),
                  descTextStyle: textStyle,
                  overlayPadding: EdgeInsets.only(left: height * 0.01),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('hello'.tr() + space,
                          style: Theme.of(context).textTheme.headline5),
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: isEn ? 0.0 : 5.0),
                            child: TextField(
                              textAlign: TextAlign.start,
                              controller: HomeCubit.get(context).nameController
                                ..text = userName,
                              style: Theme.of(context).textTheme.headline5,
                              onSubmitted: (value) =>
                                  CacheHelper.cacheUserInfo(userName: value),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Future showSettingsModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (context) => const SettingModalSheet(),
    );
  }
}
