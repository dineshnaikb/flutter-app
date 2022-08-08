import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class PrivateChat extends StatefulWidget {
  @override
  State<PrivateChat> createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  Map userDetails = {};
  List messages = [];
  fetchChats() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    print(
        'https://nextopay.com/uploop/chat_messages?chat_type=2&userid=${json.decode(_prefs.getString("user_obj")!)['user_id']}&to_userid=${userDetails['user_id']}');
    Response response = await Dio().get(
        'https://nextopay.com/uploop/chat_messages?chat_type=2&userid=${json.decode(_prefs.getString("user_obj")!)['user_id']}&to_userid=${userDetails['user_id']}');

    print(json.decode(response.data)['data'].toList());

    messages = json.decode(response.data)['data'].toList().reversed.toList();
    setState(() {});
  }

  sendMessage() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    FormData formData = FormData.fromMap({
      'chat_type': 2,
      'comment': message.text,
      'userid': json.decode(_prefs.getString("user_obj")!)['user_id'],
      'to_userid': userDetails['user_id']
    });
    message.clear();
    print('https://nextopay.com/uploop/chat');
    Response response =
        await Dio().post('https://nextopay.com/uploop/chat', data: formData);

    fetchChats();
    setState(() {});
  }

  TextEditingController message = new TextEditingController();

  @override
  void initState() {
    fetchChats();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userDetails = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            minRadius: 12.0.w,
            backgroundImage: NetworkImage(userDetails['pic']),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Text(userDetails['user_name']),
          SizedBox(
            height: 3.0.h,
          ),
          Text(userDetails['user_name']),
          SizedBox(
            height: 2.0.h,
          ),
          Flexible(
              //height: 55.0.h,
              child: ListView.builder(
                  itemCount: messages.length,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return messages[index]['user_id'] != userDetails['user_id']
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1.0.h, horizontal: 2.5.w),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 2.5.w),
                                  alignment: Alignment.centerRight,
                                  child: Text(messages[index]['date_time'],
                                      style: GoogleFonts.raleway(
                                          color: Theme.of(context)
                                              .feedTextSecondaryColor)),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 2.0.w),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(134, 207, 217, 1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    messages[index]['message'],
                                    style: GoogleFonts.raleway(
                                        color: Theme.of(context)
                                            .textSecondaryColor),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1.0.h, horizontal: 2.5.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              messages[index]['pic']),
                                        ),
                                        SizedBox(
                                          width: 1.0.w,
                                        ),
                                        Text(messages[index]['user_name'])
                                      ],
                                    ),
                                    Text(messages[index]['date_time'],
                                        style: GoogleFonts.raleway(
                                            color: Theme.of(context)
                                                .feedTextSecondaryColor)),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 2.0.w),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryBackgroundColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    messages[index]['message'],
                                    style: GoogleFonts.raleway(
                                        color:
                                            Theme.of(context).textPrimaryColor),
                                  ),
                                )
                              ],
                            ),
                          );
                  })),
          Container(
            margin: EdgeInsets.only(left: 2.0.w, right: 2.0.w, bottom: 2.0.h),
            child: TextFormField(
                controller: message,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    fillColor: Theme.of(context).textFieldColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintStyle: GoogleFonts.raleway(
                        color: Theme.of(context).feedTextSecondaryColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: 'Text Message',
                    // hintStyle: GoogleFonts.raleway(),
                    prefixIcon: Icon(
                      Icons.image_outlined,
                      color: Theme.of(context).appBarIconColor,
                    ),
                    // prefixIcon: Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 2.0.w,
                    //     ),
                    //     Icon(
                    //       Icons.image_outlined,
                    //       color: Theme.of(context).appBarIconColor,
                    //     ),
                    //     SizedBox(
                    //       width: 2.0.w,
                    //     ),
                    //     Icon(Icons.emoji_emotions_outlined,
                    //         color: Theme.of(context).appBarIconColor)
                    //   ],
                    // ),
                    suffixIcon: Transform.rotate(
                      angle: -40 * pi / 180,
                      child: InkWell(
                        onTap: sendMessage,
                        child: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
