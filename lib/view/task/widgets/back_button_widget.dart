import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(12.0), child: BackButton());
  }
}
