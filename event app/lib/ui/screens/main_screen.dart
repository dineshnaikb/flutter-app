import 'dart:io';
import 'dart:ui';

import 'package:events/bottom_bar_icons.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/bottombar_cubit.dart';
import 'package:events/ui/screens/create_event_screen.dart';
import 'package:events/ui/screens/main_app_screen.dart';
import 'package:events/ui/screens/pages/feed_screen.dart';
import 'package:events/ui/screens/pages/friends_screen.dart';
import 'package:events/ui/screens/pages/g_screen.dart';
import 'package:events/ui/screens/map_screen.dart';
import 'package:events/ui/screens/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    FeedScreen(),
    MapScreen(),
    MainAppScreen(),
    FriendsScreen(),
    ProfileScreen()
  ];
  printPrefs() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    print(_prefs.getString("user_id"));
    print(_prefs.getString("user_obj"));
  }

  @override
  void initState() {
    printPrefs();
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return Scaffold(
      body: Stack(
        children: [
          screens.elementAt(context.watch<BottombarCubit>().state.index),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              height: 8.0.h,
              margin: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.5.h),
              decoration: BoxDecoration(
                color: Theme.of(context).bottomNavigationBarColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Transform.translate(
                    offset:
                        Platform.isAndroid ? Offset(0, 0.0.h) : Offset(0, 10),
                    child: BottomNavigationBar(
                      onTap: (index) {
                        context.read<BottombarCubit>().change(index);
                      },
                      elevation: 0,
                      currentIndex: context.read<BottombarCubit>().state.index,
                      selectedItemColor: const Color.fromRGBO(0, 156, 178, 1),
                      unselectedItemColor: Theme.of(context).appBarIconColor,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      iconSize: 20,
                      selectedFontSize: 0.0,
                      unselectedFontSize: 0.0,
                      backgroundColor: Colors.transparent,
                      items: [
                        BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: SvgPicture.asset(
                                'assets/Home.svg',
                                color: Theme.of(context).appBarIconColor,
                              ),
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/Map.svg',
                            color: Theme.of(context).appBarIconColor,
                          ),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(135, 207, 217, 1),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              FontAwesomeIcons.google,
                              color: Colors.black,
                            ),
                          ),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/Friends.svg',
                            color: Theme.of(context).appBarIconColor,
                          ),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: SvgPicture.asset(
                              'assets/Profile.svg',
                              color: Theme.of(context).appBarIconColor,
                            ),
                          ),
                          label: "",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
