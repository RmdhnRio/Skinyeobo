// lib/utils/page_transitions.dart

import 'package:flutter/material.dart';


class PageTransitions {
  // Fade transition
  static PageRouteBuilder fadeTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // Slide transition from right
  static PageRouteBuilder slideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context,animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }

  // Scale and fade transition
  static PageRouteBuilder scaleTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOutCubic;
        return ScaleTransition(
          scale: CurvedAnimation(
              parent: animation,
              curve: curve
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      }
    );
  }

  // Slide up transition
  static PageRouteBuilder slideUpTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }

  // Custom transition with rotation and scale
  static PageRouteBuilder rotateTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOutCubic;
        return RotationTransition(
          turns: CurvedAnimation(
            parent: animation,
            curve: curve,
          ),
          child: ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      }
    );
  }

  // Shared axis transition (horizontal)
  static PageRouteBuilder sharedAxisTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOutCubic;
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                (1 - animation.value) * 100,
                0,
              ),
              child: Transform.scale(
                scale: 0.9 + (animation.value * 0.1),
                child: Opacity(
                  opacity: animation.value,
                  child: child,
                ),
              ),
            );
          }
        );
      }
    );
  }

  // Material 3 inspired transition
  static PageRouteBuilder material3Transition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.5);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      }
    );
  }

  // Hero based transition helper
  static PageRouteBuilder heroTransition(widget, page, {required String heroTag}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

// Extension method for easier Navigation
extension NavigationExtension on BuildContext {
  void pushWithTransition(Widget page, {TransitionType type = TransitionType.slide}) {
    PageRouteBuilder getRoute() {
      switch (type) {
        case TransitionType.fade:
          return PageTransitions.fadeTransition(page);
        case TransitionType.slide:
          return PageTransitions.slideTransition(page);
        case TransitionType.scale:
          return PageTransitions.scaleTransition(page);
        case TransitionType.slideUp:
          return PageTransitions.slideUpTransition(page);
        case TransitionType.rotate:
          return PageTransitions.rotateTransition(page);
        case TransitionType.sharedAxis:
          return PageTransitions.sharedAxisTransition(page);
        case TransitionType.material3:
          return PageTransitions.material3Transition(page);

      }
    }
    Navigator.of(this).push(getRoute());
  }
}


// Enum for transition types
enum TransitionType {
  fade,
  slide,
  scale,
  slideUp,
  rotate,
  sharedAxis,
  material3,
}