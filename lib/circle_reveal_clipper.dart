import 'package:flutter/material.dart';

class CircleRevealClipper extends CustomClipper<Path> {
  final center;
  final animationValue;
  final radius;

  CircleRevealClipper({this.center, this.animationValue, this.radius});

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
          Rect.fromCircle(radius: radius * animationValue, center: center));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
