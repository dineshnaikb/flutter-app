import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    // fetchDataPolicy();
    super.initState();
  }

  Map dataPolicy = {};
  // fetchDataPolicy() async {
  //   final SharedPreferences _prefs = await SharedPreferences.getInstance();
  //
  //   print(_prefs.getString("user_obj"));
  //   FormData formData = FormData.fromMap(
  //       {'user_id': json.decode(_prefs.getString("user_obj")!)['user_id']});
  //   Response response = await Dio()
  //       .post('https://nextopay.com/uploop/app_setting', data: formData);
  //
  //   log(response.data);
  //   log(json.decode(response.data)['Data'].toList().toString());
  //   dataPolicy = json.decode(response.data)['Data'].toList()[0]['data_policy'];
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    dataPolicy = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)))
        ],
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
            Text(
              dataPolicy.keys.toList()[0],
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
            SizedBox(
              height: 4.0.h,
            ),
            Container(
                child: Text(
              dataPolicy.values.toList()[0],
              style: GoogleFonts.raleway(
                  fontSize: 12.0.sp,
                  color: Theme.of(context).feedTextSecondaryColor),
            )),
            Flexible(
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(vertical: 4.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () async {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 8.0.h,
                        width: 80.8.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(135, 207, 217, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Apply",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textSecondaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
