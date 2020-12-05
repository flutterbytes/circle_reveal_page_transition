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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, _createRoute()),
      ),
      body: Center(),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 2000),
      reverseTransitionDuration: Duration(milliseconds: 2000),
      opaque: false,
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var screenSize = MediaQuery.of(context).size;
        Offset center = Offset(screenSize.width - 40, screenSize.height - 40);
        double beginRadius = 0.0;
        double endRadius = screenSize.height * 1.2;

        var tween = Tween(begin: beginRadius, end: endRadius);
        var radiusTweenAnimation = animation.drive(tween);

        return ClipPath(
          clipper:
              CircleRevealClipper(radius: radiusTweenAnimation, center: center),
          child: child,
        );
      },
    );
  }
}
