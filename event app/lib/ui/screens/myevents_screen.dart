import 'dart:ui';

import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

class MyEventScreen extends StatelessWidget {
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
      body: Column(
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Text(
              "My Events",
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return MyEventItem();
                }),
          )
        ],
      ),
    );
  }
}

void show(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50))),
    builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
          height: 70.0.h,
          color: Theme.of(context).profileBottomSheetColor,
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8.0,
                sigmaY: 8.0,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).appBarIconColor,
                        )),
                  ),
                  Container(
                    width: 60.0.w,
                    child: Text(
                      "FEB 21, 6:00 PM",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Container(
                    width: 60.0.w,
                    child: Text(
                      "YACHT PARTY IN MIAMI",
                      style: GoogleFonts.raleway(
                          fontSize: 20.0.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Container(
                    width: 60.0.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: QrImage(
                        data: "1234567890",
                        version: QrVersions.auto,
                        size: 250.0,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
        ),
      );
    },
  );
}

class MyEventItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        show(context);
      },
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.srcOver),
                  fit: BoxFit.fill,
                  image: AssetImage("assets/img.png"))),
          margin: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Container(
            height: 30.0.h,
            margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Night Party in Miami",
                  style: GoogleFonts.raleway(
                      fontSize: 17.0.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Row(
                  children: [
                    Text(
                      "17 July",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                          fontSize: 12.0.sp, color: Colors.white),
                    ),
                    SizedBox(
                      width: 4.0.w,
                    ),
                    Text(
                      "6:20 pm - 3:00 am",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                          fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0.h,
                ),
              ],
            ),
          )),
    );
  }
}
