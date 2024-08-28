import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/app_theme.dart';
import 'package:myapp/auth/auth_bloc.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/navigation/navigation.dart';
import 'package:myapp/auth/custom_input.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: authBloc,
                child: const NavigationHomeScreen(),
              ),
            ),
          );
        } else if (state is AuthFailure){
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Login Error'),
              content: const Text("Invalid username or password"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }            
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.nearlyDarkBlue,
                    Colors.white
                  ],
                ),
              ),
            ),
            ClipPath(
                clipper: WaveClipper(), // Use the custom clipper here
                child: Container(
                  color: const Color.fromARGB(255, 155, 196, 237),
                ),
              ),
          ClipPath(
            clipper: CircleClipper(),
            child: Container(
              color: Colors.red.withOpacity(0.3),
            ),
          ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final double animation = state is AuthLoading ? 1.0 : 0.0;
                final waveList1 = generateWaveList1(animation, context);

                return ClipPath(
                  clipper: WaveAnimClipper(animation, waveList1),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppTheme.nearlyDarkBlue, Colors.white],
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: 500,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 80,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomInput(
                            hint: 'Username',
                            obscure: false,
                            controller: usernameController,
                            icon: const Icon(Icons.person),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0.5,
                                  blurRadius: 0.5,
                                ),
                              ],
                            ),
                          ),
                          CustomInput(
                            hint: 'Password',
                            obscure: true,
                            controller: passwordController,
                            icon: const Icon(Icons.lock),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      final user = User(
                        username: usernameController.text,
                        password: passwordController.text,
                      );
                      authBloc.add(LoginEvent(user));
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: AppTheme.nearlyDarkBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<Offset> generateWaveList1(double animation, BuildContext context) {
    final waveList1 = <Offset>[];
    final size = MediaQuery.of(context).size;

    final double waveHeight = size.height * 0.1;
    //const double waveFrequency = 0.8;
    const double waveAmplitude = 50.0;

    final double waveLength = size.width;
    const double waveSpeed = 0.8;

    for (double i = 0.0; i <= size.width + 10; i++) {
      double y = waveAmplitude * sin((i / waveLength - waveSpeed * animation) * 2 * pi);

      y += size.height - waveHeight;

      waveList1.add(Offset(i, y));
    }

    waveList1.add(Offset(size.width, size.height));
    waveList1.add(Offset(0.0, size.height));

    return waveList1;
  }
}

class WaveAnimClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveAnimClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = Path();

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