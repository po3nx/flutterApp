import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedButton extends StatelessWidget {
  AnimationController controller;
  Animation<double> width;
  Animation<double> height;
  Animation<double> radius;
  Animation<double> opacity;

  AnimatedButton({super.key, required this.controller})
      : width = Tween<double>(
          begin: 0,
          end: 500,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.5),
          ),
        ),
        height = Tween<double>(
          begin: 0,
          end: 50,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.7),
          ),
        ),
        radius = Tween<double>(
          begin: 0,
          end: 20,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0),
          ),
        ),
        opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.8),
          ),
        );

  Widget _buildAnimation(BuildContext context, Widget? widget) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: width.value,
        height: height.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.value),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 100, 127, 1),
              Color.fromRGBO(255, 123, 145, 1),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: opacity,
            child: const Text(
              "Enter",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}