import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;

  CustomPageRoute({this.direction = AxisDirection.up, @required this.child})
      : super(
          transitionDuration: Duration(milliseconds: 700),
          reverseTransitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    // return super.buildTransitions(context, animation, secondaryAnimation, child);
    // return ScaleTransition(
    //   scale: animation,
    //   child: child,
    // );

    return SlideTransition(
      position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  // ignore: missing_return
  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.left:
        return Offset(1, 0);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
    }
  }
}
