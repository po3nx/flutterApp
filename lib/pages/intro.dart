import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/auth_bloc.dart';
import 'package:myapp/auth/login.dart';
import 'package:myapp/navigation/navigation.dart';
import 'package:myapp/pages/components/care_view.dart';
import 'package:myapp/pages/components/center_next_button.dart';
import 'package:myapp/pages/components/mood_diary_vew.dart';
import 'package:myapp/pages/components/relax_view.dart';
import 'package:myapp/pages/components/splash_view.dart';
import 'package:myapp/pages/components/top_back_skip_view.dart';
import 'package:myapp/pages/components/welcome_view.dart';
import 'package:flutter/material.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({Key? key}) : super(key: key);

  @override
  IntroductionAnimationScreenState createState() => IntroductionAnimationScreenState();
}

class IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(_animationController?.value);
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!,
            ),
            RelaxView(
              animationController: _animationController!,
            ),
            CareView(
              animationController: _animationController!,
            ),
            MoodDiaryVew(
              animationController: _animationController!,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _loginClick();
    }
  }

  void _loginClick() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final state = authBloc.state;
    if (state.token != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(
              value: authBloc,
              child: const NavigationHomeScreen(),
            ),),);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(
              value: authBloc,
              child: LoginPage(),
            ),),);
    }
  }
}
