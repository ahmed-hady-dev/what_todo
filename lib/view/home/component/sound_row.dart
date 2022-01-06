// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_todo/view/home/controller/home_cubit.dart';

class SoundRow extends StatelessWidget {
  const SoundRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("sound".tr(), style: Theme.of(context).textTheme.headline6),
              CupertinoSwitch(
                activeColor: Colors.black26,
                thumbColor: Colors.black,
                value: HomeCubit.get(context).isSoundOn,
                onChanged: (value) {
                  HomeCubit.get(context).changeSound();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
