import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transition_animations/circle_reveal_clipper.dart';
import 'package:transition_animations/second_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //we have a basic navigator
            //push function
            Navigator.of(context).push(_createRoute());
          },
          child: Text("Second Page"),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      //these are arguments
      //pagebuilder, transitionbuilder, transitionduration and reversetransitionduration

      transitionDuration: Duration(milliseconds: 2000),
      reverseTransitionDuration: Duration(milliseconds: 2000),
      opaque: false,
      barrierDismissible: false,

      pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //first
        FadeTransition(
          opacity: animation,
          child: child,
        );

        //second
        double beginScale = 0.4;
        double endScale = 0.50;

        var scaleTween = Tween(begin: beginScale, end: endScale);
        var scaleTweenAnimation = animation.drive(scaleTween);
        print(scaleTweenAnimation.value);
        return ScaleTransition(
          scale: scaleTweenAnimation,
          child: child,
        );

        //third
        // zero on the x axis is left and 1 is right
        // zero on the y is top and 1 is bottom

        Offset beginOffset = Offset(0, 1);
        Offset endOffset = Offset(0, 0);

        var tween = Tween(begin: beginOffset, end: endOffset);
        var offsetTweenAnimation = animation.drive(tween);

        SlideTransition(
          position: offsetTweenAnimation,
          child: child,
        );

        //fourth
        Transform(
          transform: Matrix4.identity()..rotateY(animation.value * pi / 2),
          child: child,
        );

        //fifth
        var size = MediaQuery.of(context).size;
        Offset startingPoint = Offset(size.width, size.height);

        ClipPath(
          clipper: CircleRevealClipper(
              animationValue: animation.value,
              radius: size.height * 1.2,
              center: startingPoint),
          child: child,
        );
      },
    );
  }
}
