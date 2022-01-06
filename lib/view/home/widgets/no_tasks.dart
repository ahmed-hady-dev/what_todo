// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:what_todo/core/responsive_helper/responsive_layout.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Expanded(
      child: ResponsiveLayout(
        mobilePortrait: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 0.0, bottom: 72.0, start: 72.0, end: 72.0),
                child: Image.asset('assets/images/no_tasks.png'),
              ),
              Text('no_tasks'.tr()),
            ],
          ),
        ),
        mobileLandscape: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: isLandscape ? 72.0 : 0,
                    bottom: 72.0,
                    start: isLandscape ? 0.0 : 72.0,
                    end: 72.0),
                child: Image.asset('assets/images/no_tasks.png'),
              ),
              Text('no_tasks'.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
