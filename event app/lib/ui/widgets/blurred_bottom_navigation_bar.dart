import 'dart:ui';
import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class BlurredBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 3.0.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: BottomNavigationBar(
              onTap: (index) {},
              selectedItemColor: Color.fromRGBO(0, 156, 178, 1),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarColor.withOpacity(0.05),
              iconSize: 25,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(FontAwesomeIcons.home),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(135, 207, 217, 1),
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.userFriends),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(Icons.person),
                  ),
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
