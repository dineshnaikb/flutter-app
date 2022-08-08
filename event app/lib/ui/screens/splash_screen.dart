import 'dart:ui';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/indicator_cubit.dart';
import 'package:events/ui/widgets/carousel_slider.dart';
import 'package:events/ui/widgets/indicator_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkLogin() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("user_id") != null) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IndicatorCubit>(
      create: (context) => IndicatorCubit(),
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5.0.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IndicatorIndex(),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      Row(children: [
                        Container(
                            child: Image.asset(
                          Theme.of(context).logo,
                          width: 20.0.w,
                        ))
                      ]),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      MovingText(),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      CustomIndicator(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => Navigator.pushNamed(context, '/signin'),
                        child: Container(
                            alignment: Alignment.center,
                            width: 39.0.w,
                            height: 7.3.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromRGBO(151, 151, 151, 1)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.raleway(fontSize: 15.0.sp),
                            )),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => Navigator.pushNamed(context, '/signup'),
                        child: Container(
                            alignment: Alignment.center,
                            width: 39.0.w,
                            height: 7.3.h,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(135, 207, 217, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.raleway(
                                  fontSize: 15.sp, color: Colors.black),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class MovingText extends StatelessWidget {
  List<String> list = [
    "Explore New Connections",
    "Adventure Awaits You",
    "Meet like-minded people",
    "Explore New Connections",
    "Adventure Awaits You",
    "Meet like-minded people",
  ];

  @override
  Widget build(BuildContext context) {
    return Text(
      list[context.watch<IndicatorCubit>().state.counter],
      style: GoogleFonts.raleway(fontSize: 28.0.sp),
    );
  }
}
