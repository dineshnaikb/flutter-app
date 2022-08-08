import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class EventAnnouncementsScreen extends StatefulWidget {
  String eventId;
  String eventName;
  EventAnnouncementsScreen(this.eventId, this.eventName);
  @override
  State<EventAnnouncementsScreen> createState() =>
      _EventAnnouncementsScreenState();
}

class _EventAnnouncementsScreenState extends State<EventAnnouncementsScreen> {
  String userId = '';
  List messages = [];
  fetchChats() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    userId = json.decode(_prefs.getString("user_obj")!)['user_id'];
    FormData formData = FormData.fromMap({
      'user_id': json.decode(_prefs.getString("user_obj")!)['user_id'],
      'event_id': widget.eventId
    });
    // print(
    //     'https://nextopay.com/uploop/chat_messages?chat_type=2&userid=${json.decode(_prefs.getString("user_obj")!)['user_id']}&to_userid=${userDetails['user_id']}');
    Response response = await Dio().post(
        'https://nextopay.com/uploop/create_announcement',
        data: formData);

    print(json.decode(response.data)['Data']);
    if (json.decode(response.data)['Data'] != 'No data')
      messages = json.decode(response.data)['Data'].toList().reversed.toList();
    setState(() {});
  }

  sendMessage() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    FormData formData = FormData.fromMap(
        {'user_id': userId, 'event_id': widget.eventId, 'data': message.text});
    message.clear();
    // print('https://nextopay.com/uploop/chat');
    Response response = await Dio().post(
        'https://nextopay.com/uploop/create_announcement',
        data: formData);

    fetchChats();
    setState(() {});
  }

  TextEditingController message = new TextEditingController();

  @override
  void initState() {
    fetchChats();
    print(widget.eventId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // userDetails = ModalRoute.of(context)!.settings.arguments as Map;
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
          // CircleAvatar(
          //   minRadius: 12.0.w,
          //   backgroundImage: NetworkImage(userDetails['created_by_name']),
          // ),
          // SizedBox(
          //   height: 2.0.h,
          // ),
          Text(widget.eventName,
              style: GoogleFonts.raleway(color: Colors.white, fontSize: 26)),
          // SizedBox(
          //   height: 3.0.h,
          // ),
          // Text(userDetails['created_by_name']),
          SizedBox(
            height: 2.0.h,
          ),
          Flexible(
              //height: 55.0.h,
              child: ListView.builder(
                  itemCount: messages.length,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return messages[index]['created_by_id'] != userId
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1.0.h, horizontal: 2.5.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      minRadius: 4.0.w,
                                      backgroundImage: NetworkImage(
                                          'https://nextopay.com/uploop/images/users/user.png'),
                                    ),
                                    SizedBox(
                                      width: 4.0.w,
                                    ),
                                    Text(messages[index]['created_by_name']),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 2.5.w),
                                      alignment: Alignment.centerRight,
                                      child: Text(messages[index]['created_on'],
                                          style: GoogleFonts.raleway(
                                              color: Theme.of(context)
                                                  .feedTextSecondaryColor)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 2.0.w),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryBackgroundColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    messages[index]['discription'],
                                    style: GoogleFonts.raleway(
                                        color:
                                            Theme.of(context).textPrimaryColor),
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
                                              'https://nextopay.com/uploop/images/users/user.png'),
                                        ),
                                        SizedBox(
                                          width: 4.0.w,
                                        ),
                                        Text(messages[index]['created_by_name'])
                                      ],
                                    ),
                                    Text(messages[index]['created_on'],
                                        style: GoogleFonts.raleway(
                                            color: Theme.of(context)
                                                .feedTextSecondaryColor)),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 2.0.w),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(134, 207, 217, 1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    messages[index]['discription'],
                                    style: GoogleFonts.raleway(
                                        color: Theme.of(context)
                                            .textSecondaryColor),
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
                    hintText: 'Announcement Text',
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
