import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
        elevation: 0,
        title: Image.asset(
          Theme.of(context).logo,
          width: 22.0.w,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Privacy",
                style: GoogleFonts.raleway(
                    fontSize: 20.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
            ),
            SizedBox(
              height: 4.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: GoogleFonts.raleway(
                      fontSize: 15.0.sp,
                      color: Theme.of(context).textPrimaryColor),
                ),
                FlutterSwitch(
                  width: 14.0.w,
                  height: 4.0.h,
                  valueFontSize: 25.0,
                  toggleSize: 6.0.w,
                  activeColor: Color.fromRGBO(38, 174, 101, 1),
                  value: context.watch<SettingsBloc>().state.notifications,
                  borderRadius: 30.0,
                  showOnOff: false,
                  onToggle: (val) {
                    context
                        .read<SettingsBloc>()
                        .add(SettingsToggleNotifications(enabled: val));
                  },
                )
              ],
            ),
            SizedBox(
              height: 4.0.h,
            ),
            // InkWell(
            //   splashFactory: NoSplash.splashFactory,
            //   highlightColor: Colors.transparent,
            //   hoverColor: Colors.transparent,
            //   onTap: () {
            //     Navigator.pushNamed(context, '/privacy_policy');
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Restricted Accounts",
            //         style: GoogleFonts.raleway(
            //             fontSize: 15.0.sp,
            //             color: Theme.of(context).textPrimaryColor),
            //       ),
            //       Icon(Icons.arrow_forward)
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 4.0.h,
            // ),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () async {
                final SharedPreferences _prefs =
                    await SharedPreferences.getInstance();

                print(_prefs.getString("user_obj"));

                Response response = await Dio().get(
                    'https://nextopay.com/uploop/blocked_user?userid=${json.decode(_prefs.getString("user_obj")!)['user_id']}');

                log(response.data);
                log(json.decode(response.data)['data'].toList().toString());
                List accounts = json.decode(response.data)['data'].toList();
                Navigator.pushNamed(context, '/blocked_accounts',
                    arguments: accounts);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Blocked Accounts",
                    style: GoogleFonts.raleway(
                        fontSize: 15.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
            SizedBox(
              height: 4.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comments",
                  style: GoogleFonts.raleway(
                      fontSize: 15.0.sp,
                      color: Theme.of(context).textPrimaryColor),
                ),
                FlutterSwitch(
                  width: 14.0.w,
                  height: 4.0.h,
                  valueFontSize: 25.0,
                  toggleSize: 6.0.w,
                  activeColor: Color.fromRGBO(38, 174, 101, 1),
                  value: context.watch<SettingsBloc>().state.comments,
                  borderRadius: 30.0,
                  showOnOff: false,
                  onToggle: (val) {
                    context
                        .read<SettingsBloc>()
                        .add(SettingsToggleComments(enabled: val));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
