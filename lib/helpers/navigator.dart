import 'package:flutter/material.dart';

void navigateAndKeepStack(BuildContext context, Widget targetRoute) =>
    Navigator.push(
      context,

      CustomScalePageRoute(
        builder: (context) => targetRoute, settings: RouteSettings(),

      ),

    );



void navigateAndClearStack(BuildContext context, Widget targetRoute) =>
    Navigator.of(context).pushAndRemoveUntil(
      CustomFadePageRoute(
        builder: (context) => targetRoute, settings: const RouteSettings(),
      ),
          (Route<dynamic> route) => false,
    );


class CustomFadePageRoute<T> extends MaterialPageRoute<T> {
  CustomFadePageRoute({required WidgetBuilder builder,required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
class CustomScalePageRoute<T> extends MaterialPageRoute<T> {
  CustomScalePageRoute({required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}


class CustomSizePageRoute<T> extends MaterialPageRoute<T> {
  CustomSizePageRoute({required WidgetBuilder builder,required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SizeTransition(
      sizeFactor: animation,
      child: child,
    );
  }
}