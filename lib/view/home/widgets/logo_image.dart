import 'package:flutter/material.dart';

class LogoImage extends StatefulWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoImage> createState() => _LogoImageState();
}

class _LogoImageState extends State<LogoImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ))
    ..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
          begin: const Offset(0, 0.15), end: Offset.zero)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          SlideTransition(
            position: _animation,
            transformHitTests: false,
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                  top: 22.0, bottom: 22.0, start: 16.0, end: 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/what_todo_splash.png',
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * 00.2
                          : MediaQuery.of(context).size.height * 00.2,
                ),
              ),
            ),
          ),
          Text('Hello, Peter.', style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }
}
