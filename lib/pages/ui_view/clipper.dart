
import 'package:flutter/material.dart';

class WaveAnimClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveAnimClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path =  Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveAnimClipper oldClipper) =>
      animation != oldClipper.animation;
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.75);

    final firstControlPoint = Offset(size.width * 0.2, size.height * 0.9);
    final firstEndPoint = Offset(size.width * 0.4, size.height * 0.75);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.6, size.height * 0.6);
    final secondEndPoint = Offset(size.width * 0.8, size.height * 0.75);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    final thirdControlPoint = Offset(size.width * 0.9, size.height * 0.8);
    final thirdEndPoint = Offset(size.width, size.height * 0.75);
    path.quadraticBezierTo(
      thirdControlPoint.dx,
      thirdControlPoint.dy,
      thirdEndPoint.dx,
      thirdEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 5, size.height / 6);
    final radius = size.width / 6;
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    path.addOval(Rect.fromCircle(center: Offset(size.width / 9, size.height / 8), radius: size.width / 8));
    path.addOval(Rect.fromCircle(center: Offset(size.width / 3, size.height / 5), radius: size.width / 9));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
class AbstractShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Define your abstract shape here
    // You can use curves, lines, or any other path commands
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.75, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.25, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}