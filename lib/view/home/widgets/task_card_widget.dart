// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:what_todo/view/home/controller/home_cubit.dart';
import '../../../core/theme/theme_cubit.dart';

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
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDark = ThemeCubit.get(context).isDark;
    final double width = MediaQuery.of(context).size.width;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool isSubtitle = subTitle != null;
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
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: isDark ? Colors.white24 : Colors.white,
            borderRadius: BorderRadius.circular(22.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,
                maxLines: isLandscape ? 2 : null,
                overflow: isLandscape ? TextOverflow.ellipsis : null,
                style:
                    textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
            if (isSubtitle)
              Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  subTitle ?? '',
                  style: textTheme.bodyText1,
                  overflow: isLandscape ? TextOverflow.ellipsis : null,
                ),
              )
          ],
        ),
      ),
    );
  }
}
