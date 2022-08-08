import 'dart:ui';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/bottombar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String publishableKey =
    'pk_test_51L0r4NH4wNzZIiLAcxS0YtJHeBeFp3MPXR0b6dBicuPqqk3jLkTpKohChAtdyjkYhR1IGBWFDygmyODmBvvtvpW900Ln8mJdQR';
const String secretKey = 'your secretKey';

Widget buildBottomBar(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 8.0.w, right: 8.0.w, bottom: 2.0.h),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: 9.0.h,
          color: Theme.of(context).bottomNavigationBarColor.withOpacity(0.05),
          child: BottomNavigationBar(
            onTap: (index) {
              context.read<BottombarCubit>().change(index);
              Navigator.pushNamed(context, '/main');
            },
            selectedItemColor: Theme.of(context).appBarIconColor,
            unselectedItemColor: Theme.of(context).appBarIconColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            iconSize: 20,
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
                  padding: const EdgeInsets.all(10),
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
                    )),
                label: "",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
