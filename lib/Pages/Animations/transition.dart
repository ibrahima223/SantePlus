import 'package:flutter/material.dart';

enum TransitionType {
  fade,
  slide,
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget page;
  final TransitionType transitionType;
  CustomPageRoute({required this.page, required this.transitionType})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case TransitionType.fade:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        case TransitionType.slide:
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
      }
    },
  );
}