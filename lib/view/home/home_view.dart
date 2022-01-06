import 'package:flutter/material.dart';
import 'package:what_todo/core/responsive_helper/responsive_layout.dart';
import 'package:what_todo/view/home/component/home_landscape_layout.dart';
import 'package:what_todo/view/home/component/home_portrait_layout.dart';
import '../../core/router/router.dart';
import 'widgets/gradient_fab.dart';
import '../task/task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const ResponsiveLayout(
                mobilePortrait: HomePortraitLayout(),
                mobileLandscape: HomeLandscapeLayout()),
            GradientFAB(
                isHome: true,
                onPressed: () => MagicRouter.navigateTo(const TaskView())),
          ],
        ),
      ),
    );
  }
}
