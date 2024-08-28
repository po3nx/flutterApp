import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/app_theme.dart';
import 'package:myapp/auth/auth_bloc.dart';
import 'package:myapp/auth/login.dart';
import 'package:myapp/navigation/home_drawer.dart';
import 'package:myapp/navigation/drawer_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/feedback_screen.dart';
import 'package:myapp/pages/help_screen.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/invite_friend_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  NavigationHomeScreenState createState() => NavigationHomeScreenState();
}

class NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.token == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: authBloc,
                  child: LoginPage(),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Container(
              color: AppTheme.white,
              child: SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  backgroundColor: AppTheme.nearlyWhite,
                  body:  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) { 
                      return DrawerUserController(
                        screenIndex: drawerIndex,
                        drawerWidth: MediaQuery.of(context).size.width * 0.75,
                        onDrawerCall: (DrawerIndex drawerIndexdata) {
                          changeIndex(drawerIndexdata);
                          //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
                        },
                        screenView: screenView,
                        //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
                      );
                    }
                  ),
                ),
              ),
            );
          }
        )
      )
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView =  const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = const HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = const FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = const InviteFriend();
          });
          break;
        default:
          break;
      }
    }
  }
}
