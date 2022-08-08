import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:events/constants.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:events/core/app_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class WriteCommentScreen extends StatefulWidget {
  @override
  State<WriteCommentScreen> createState() => _WriteCommentScreenState();
}

class _WriteCommentScreenState extends State<WriteCommentScreen> {
  EventState event = EventState();
  TextEditingController commentController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as EventState;
    print(event.uid);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBody: true,
      appBar: CustomAppBar.build(context, null),
      body: Column(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                Text(
                  'Write A Comment',
                  style: GoogleFonts.raleway(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Comment cannot be empty";
                    }
                  },
                  onChanged: (value) {},
                  controller: commentController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    hintStyle: GoogleFonts.raleway(
                        color: Theme.of(context).feedTextSecondaryColor),
                    fillColor: Theme.of(context).textFieldColor,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Write your comment',
                  ),
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                RoundedLoadingButton(
                  animateOnTap: false,
                  color: const Color.fromRGBO(134, 207, 217, 1),
                  child: Container(
                    alignment: Alignment.center,
                    height: 8.0.h,
                    width: 80.8.w,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(134, 207, 217, 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Post Comment",
                      style: GoogleFonts.raleway(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  controller: _btnController,
                  onPressed: () async {
                    _btnController.start();
                    final SharedPreferences _prefs =
                        await SharedPreferences.getInstance();

                    String userId = _prefs.getString("user_id")!;
                    var formData = FormData.fromMap({
                      'event_id': event.uid,
                      'userid': _prefs.getString("user_id")!,
                      'comment': commentController.text
                    });
                    Response response = await Dio().post(
                        'https://nextopay.com/uploop/comments',
                        data: formData);

                    var resData = jsonDecode(response.data);
                    print(resData);
                    _btnController.stop();
                  },
                ),
                SizedBox(
                  height: 15.0.h,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
