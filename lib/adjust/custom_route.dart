import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (settings.isInitialRoute) {
      return child;
    }
    return 
    // FadeTransition(       //for fade transition uncomment this
    //   opacity: animation,
    //   child: child,
    // );
     SlideTransition(        //for slide transition uncomment this (sliding)
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
    // ScaleTransition(      //for scale transition uncomment this (Zoom in and Zoom out)
    //   scale: Tween<double>(
    //               begin: 0.0,
    //               end: 1.0,
    //             ).animate(
    //               CurvedAnimation(
    //                 parent: animation,
    //                 curve: Curves.fastOutSlowIn,
    //               ),
    //             ),
    //             child: child,
    //           );
      
  }
}

// class CustomPageTransitionBuilder extends PageTransitionsBuilder {
//  @override
//   Widget buildTransitions<T>(
//     PageRoute<T> route,
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     if (route.settings.isInitialRoute) {
//       return child;
//     }
//     return FadeTransition(
//       opacity: animation,
//       child: child,
//     );
//   }
// }