// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:what_todo/core/cacheHelper/cache_helper.dart';
import 'package:what_todo/core/router/router.dart';
import 'package:what_todo/widgets/simple_button.dart';

class NameDialog extends StatefulWidget {
  const NameDialog({Key? key}) : super(key: key);

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Container(
        height: isLandscape ? height * 0.6 : height * 0.3,
        width: isLandscape ? width * 0.45 : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.2,
                height: isLandscape ? height * 0.15 : height * 0.079,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
                child: Image.asset('assets/images/what_todo_splash.png'),
              ),
              const SizedBox(height: 4),
              Text("enter_name".tr(),
                  style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: nameController,
                  onSubmitted: (value) async {
                    await CacheHelper.cacheUserInfo(userName: value);
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: accentColor,
                    hintText: 'name'.tr(),
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8.0),
                    border: customOutlineInputBorder(color: primaryColor),
                    focusedBorder:
                        customOutlineInputBorder(color: secondaryColor),
                    errorBorder: customOutlineInputBorder(color: errorColor),
                    enabledBorder:
                        customOutlineInputBorder(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SimpleButton(
                    text: "not_now".tr(),
                    onPressed: MagicRouter.pop,
                    invertedColors: true,
                  ),
                  SimpleButton(
                    text: "done".tr(),
                    onPressed: () async {
                      await CacheHelper.cacheUserInfo(
                          userName: nameController.value.text);
                      FocusScope.of(context).unfocus();
                      MagicRouter.pop();
                      setState(() {});
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder customOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    );
  }
}
