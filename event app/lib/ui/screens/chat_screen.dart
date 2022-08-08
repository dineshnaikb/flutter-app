import 'dart:math';

import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
        elevation: 0,
        actions: [
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 20),
              child: Text("21 Members"))
        ],
        title: Image.asset(
          Theme.of(context).logo,
          width: 22.0.w,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Text("Yacht Party in Miami",
                style: GoogleFonts.raleway(fontSize: 20.0.sp)),
            SizedBox(
              height: 2.0.h,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return InboxItem();
                  }),
            ),
            Container(
              margin: EdgeInsets.only(left: 1.0.w, right: 1.0.w, bottom: 2.0.h),
              child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelText: 'Text Message',
                      hintStyle: GoogleFonts.raleway(),
                      prefixIcon: Row(
                        children: [
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Icon(
                            Icons.image_outlined,
                            color: Theme.of(context).appBarIconColor,
                          ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Icon(Icons.emoji_emotions_outlined,
                              color: Theme.of(context).appBarIconColor)
                        ],
                      ),
                      suffixIcon: Transform.rotate(
                        angle: -40 * pi / 180,
                        child: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

class InboxItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 4.0.w,
                  ),
                  Text("Cameron Williamson")
                ],
              ),
              Text(
                "Today 16:20",
                style: GoogleFonts.raleway(
                    color: Theme.of(context).feedTextSecondaryColor),
              )
            ],
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).textFieldColor,
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Loremrinter took a galley of type and scrambled it to make a type specimen book.")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
