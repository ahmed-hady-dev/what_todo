// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:what_todo/constants/constants.dart';
import 'package:what_todo/core/cacheHelper/cache_helper.dart';
import 'package:what_todo/view/home/controller/home_cubit.dart';
import 'package:what_todo/view/home/widgets/task_card_widget_container.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget(
      {Key? key,
      required this.title,
      this.subTitle,
      required this.onTap,
      required this.id})
      : super(key: key);
  final String title;
  final int id;
  final String? subTitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSubtitle = subTitle != null;
    final textStyle =
        Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white);
    final isFirst = CacheHelper.read(key: 'isFirstTime');
    return FocusedMenuHolder(
      blurSize: 8.0,
      menuOffset: 8.0,
      menuItemExtent: 45,
      bottomOffsetHeight: 80,
      menuWidth: 300,
      menuBoxDecoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      menuItems: [
        FocusedMenuItem(
            title: Text('delete_task'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white)),
            onPressed: () async =>
                await HomeCubit.get(context).deleteTask(id: id),
            backgroundColor: Colors.red,
            trailingIcon:
                const Icon(Icons.delete_forever_rounded, color: Colors.white)),
      ],
      onPressed: onTap,
      child: isFirst
          ? Showcase(
              key: Constant.taskKey,
              descTextStyle: textStyle,
              radius: BorderRadius.circular(22.0),
              description: 'showcase_task_card'.tr(),
              showcaseBackgroundColor: const Color(0xFF7349FE),
              child: TaskCardWidgetContainer(
                  title: title, isSubtitle: isSubtitle, subTitle: subTitle),
            )
          : TaskCardWidgetContainer(
              title: title, isSubtitle: isSubtitle, subTitle: subTitle),
    );
  }
}
