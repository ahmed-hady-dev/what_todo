import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../core/responsive_helper/responsive_layout.dart';
import 'component/home_landscape_layout.dart';
import 'component/home_portrait_layout.dart';
import '../../core/router/router.dart';
import 'widgets/gradient_fab.dart';
import '../task/task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
          builder: (context) => SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Stack(
                    children: [
                      const ResponsiveLayout(
                          mobilePortrait: HomePortraitLayout(),
                          mobileLandscape: HomeLandscapeLayout()),
                      GradientFAB(
                          isHome: true,
                          onPressed: () =>
                              MagicRouter.navigateTo(const TaskView())),
                    ],
                  ),
                ),
              )),
    );
  }
}
