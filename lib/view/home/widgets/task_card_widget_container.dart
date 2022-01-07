import 'package:flutter/material.dart';
import '../../../core/theme/theme_cubit.dart';

class TaskCardWidgetContainer extends StatelessWidget {
  const TaskCardWidgetContainer({
    Key? key,
    required this.title,
    required this.isSubtitle,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final bool isSubtitle;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDark = ThemeCubit.get(context).isDark;
    final double width = MediaQuery.of(context).size.width;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool isSubtitle = subTitle != null;
    return Container(
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
    );
  }
}
