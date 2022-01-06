// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:what_todo/core/cacheHelper/cache_helper.dart';
import 'package:what_todo/view/home/controller/home_cubit.dart';

class NameRow extends StatelessWidget {
  const NameRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text('name'.tr(),
                style: Theme.of(context).textTheme.headline6)),
        Expanded(
          flex: 2,
          child: TextField(
            controller: HomeCubit.get(context).nameController
              ..text = CacheHelper.getUserName ?? '',
            decoration: InputDecoration(
                hintText: 'enter_name'.tr(),
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
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
      ],
    );
  }
}
