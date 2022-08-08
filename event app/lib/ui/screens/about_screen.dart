import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AboutScreen extends StatelessWidget {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "About",
                style: GoogleFonts.raleway(
                    fontSize: 20.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () async {
                final SharedPreferences _prefs =
                    await SharedPreferences.getInstance();

                print(_prefs.getString("user_obj"));
                FormData formData = FormData.fromMap({
                  'user_id':
                      json.decode(_prefs.getString("user_obj")!)['user_id']
                });
                Response response = await Dio().post(
                    'https://nextopay.com/uploop/app_setting',
                    data: formData);

                log(response.data);
                log(json.decode(response.data)['Data'].toList().toString());
                String dataPolicy = json
                    .decode(response.data)['Data']
                    .toList()[0]['data_policy'];
                Navigator.pushNamed(context, '/privacy_policy',
                    arguments: {'Data Policy': dataPolicy});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Data Policy",
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
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () async {
                final SharedPreferences _prefs =
                    await SharedPreferences.getInstance();

                print(_prefs.getString("user_obj"));
                FormData formData = FormData.fromMap({
                  'user_id':
                      json.decode(_prefs.getString("user_obj")!)['user_id']
                });
                Response response = await Dio().post(
                    'https://nextopay.com/uploop/app_setting',
                    data: formData);

                log(response.data);
                log(json.decode(response.data)['Data'].toList().toString());
                String dataPolicy = json
                    .decode(response.data)['Data']
                    .toList()[0]['terms_ofuse'];
                Navigator.pushNamed(context, '/privacy_policy',
                    arguments: {'Terms of Use': dataPolicy});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Terms of Use",
                    style: GoogleFonts.raleway(
                        fontSize: 15.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
