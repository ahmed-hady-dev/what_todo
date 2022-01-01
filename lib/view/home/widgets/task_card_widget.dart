import 'package:flutter/material.dart';
import '../../../core/theme/theme_cubit.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key, this.title, this.subTitle = '', this.onTap})
      : super(key: key);
  final String? title;
  final String? subTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22.0),
      child: Ink(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: ThemeCubit.get(context).isDark ? Colors.white24 : Colors.white,
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title ?? '(Unnamed Task)',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subTitle == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(subTitle ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(height: 1.5)),
                  )
          ],
        ),
      ),
    );
  }
}
