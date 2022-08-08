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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class EventInfoScreen extends StatefulWidget {
  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  EventState eventDetails = EventState();
  fetchEventDetails(String eventId) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    log('https://nextopay.com/uploop/event_detail?userid=${_prefs.getString("user_id")}&event_id=${eventId}');
    Response response = await Dio().get(
        'https://nextopay.com/uploop/event_detail?userid=${_prefs.getString("user_id")}&event_id=${eventId}');

    eventDetails = await EventState.fromMap(
        json.decode(response.data)['data'].toList()[0]);
    print('Event Details');
    print(eventDetails);
  }

  List<Widget> eventComments = [];
  fetchComments() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    print(eventDetails.uid);
    print(
        'https://nextopay.com/uploop/event_comments?event_id=${event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');
    Response response = await Dio().get(
        'https://nextopay.com/uploop/event_comments?event_id=${event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');

    log(response.data);
    if (json.decode(response.data)['message'] != 'No data exhist')
      json.decode(response.data)['data'].toList().forEach((element) {
        eventComments.add(Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 6.0.w,
                    backgroundImage: NetworkImage(
                        '${element['User_detail'].toList()[0]['Pic']}'),
                  ),
                  SizedBox(
                    width: 5.0.w,
                  ),
                  Text(
                    '${element['User_detail'].toList()[0]['Name']}',
                  ),
                  Spacer(),
                  Text(
                    '${element['date']}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0.w),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.0.h,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                          child: Text(
                            '${element['comment']}',
                            textAlign: TextAlign.start,
                          ))),
                  SizedBox(
                    height: 1.0.h,
                  ),
                ],
              ),
            ),
          ],
        ));
      });

    setState(() {});
  }

  List invitedFriends = [];
  EventState event = EventState();
  bool showIcon = false;
  String? userId;
  fetchInvitedFriends() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    print(eventDetails.uid);
    userId = json.decode(_prefs.getString("user_obj")!)['user_id'];
    Response response = await Dio().get(
        'https://nextopay.com/uploop/event_invite?event_id=${event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');
    log('https://nextopay.com/uploop/event_invite?event_id=${event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');
    if (json.decode(response.data)['message'] != 'No data exhist') {
      invitedFriends = json.decode(response.data)['data'].toList();
    }

    setState(() {});
  }

  @override
  void initState() {
    // EventState eventTemp =
    //     ModalRoute.of(context)!.settings.arguments as EventState;
    // fetchEventDetails("1");

    fetchInvitedFriends();
    fetchComments();
    // final SharedPreferences _prefs = await SharedPreferences.getInstance();
    //
    // print(_prefs.getString("user_obj"));
    // Response response = await Dio().get(
    //     'https://nextopay.com/uploop/event_detail?userid=${_prefs.getString("user_id")}&event_id=1');
    // eventDetails =
    //     EventState.fromMap(json.decode(response.data['data'].toList()[0]));
    // print(eventDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as EventState;
    print(event.isCurrUserEvent);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBody: true,
      appBar: CustomAppBar.build(
          context, event.isCurrUserEvent ? Icons.edit : null),
      bottomNavigationBar: buildBottomBar(context),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Container(
                        height: 25.0.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: NetworkImage(
                                event.img1,
                              ),
                              fit: BoxFit.fill,
                            ))),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      children: [
                        Text(
                          event.title,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.raleway(
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/Date.svg',
                              color: Theme.of(context).appBarIconColor,
                            ),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Text(
                              event.event_date,
                              style: GoogleFonts.raleway(
                                  color:
                                      Theme.of(context).feedTextSecondaryColor),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/Location.svg',
                              color: Theme.of(context).appBarIconColor,
                            ),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Text(
                              event.place,
                              style: GoogleFonts.raleway(
                                  color:
                                      Theme.of(context).feedTextSecondaryColor),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     // Navigator.pushNamed(context, '/invited_friends');
                        //   },
                        //   child: Row(
                        //     children: [
                        //       Text("Invited",
                        //           style: GoogleFonts.raleway(
                        //               color: Theme.of(context).textPrimaryColor,
                        //               fontSize: 12.9.sp)),
                        //       SizedBox(
                        //         width: 2.0.w,
                        //       ),
                        //       Text(
                        //         invitedFriends.length.toString(),
                        //         style: GoogleFonts.raleway(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 12.0.sp,
                        //             color: Theme.of(context)
                        //                 .feedTextSecondaryColor),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Row(
                          children: [
                            Text("Invited",
                                style: GoogleFonts.raleway(
                                    color: Theme.of(context).textPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.9.sp)),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Text(
                              invitedFriends.length.toString(),
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0.sp,
                                  color:
                                      Theme.of(context).feedTextSecondaryColor),
                            )
                          ],
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => Navigator.pushNamed(
                              context, '/invited_friends',
                              arguments: event),
                          child: Container(
                            alignment: Alignment.center,
                            height: 4.5.h,
                            width: 35.0.w,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Theme.of(context).textPrimaryColor)),
                            child: Text("Invited Friends",
                                style: GoogleFonts.raleway(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textPrimaryColor)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                  ],
                ),
              ),
              invitedFriends.length != 0
                  ? Container(
                      height: 15.0.h,
                      padding: EdgeInsets.only(left: 2.0.w),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: invitedFriends.length,
                          itemBuilder: (context, index) {
                            return InvitedListItem(invitedFriends[index]);
                          }),
                    )
                  : Container(),
              SizedBox(
                height: 3.0.h,
              ),
              if (event.paid_event == true)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tickets",
                          style: GoogleFonts.raleway(
                              color: Theme.of(context).textPrimaryColor,
                              fontSize: 12.9.sp)),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Tickets",
                                  style:
                                      GoogleFonts.raleway(color: Colors.grey)),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Text(event.total_ticket_volume,
                                  style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sold",
                                  style:
                                      GoogleFonts.raleway(color: Colors.grey)),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Text(event.event_map['Ticket_sale'].toString(),
                                  style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ticket Price",
                                  style:
                                      GoogleFonts.raleway(color: Colors.grey)),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Text(event.female_price,
                                  style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total",
                                  style:
                                      GoogleFonts.raleway(color: Colors.grey)),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Text(
                                  "\$${event.event_map['Total_ticket_sale_amount']}",
                                  style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              if (event.paid_event == true)
                SizedBox(
                  height: 5.0.h,
                ),
              ...eventComments,
              SizedBox(
                height: 15.0.h,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class InvitedListItem extends StatefulWidget {
  Map friendDetails = {};
  InvitedListItem(this.friendDetails);
  @override
  State<InvitedListItem> createState() => _InvitedListItemState();
}

class _InvitedListItemState extends State<InvitedListItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
      alignment: Alignment.center,
      width: 18.0.w,
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 1.0.h,
          ),
          CircleAvatar(
            minRadius: 6.0.w,
            backgroundImage: NetworkImage(widget.friendDetails['pic']),
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Center(
            child: Container(
                child: Text(
              widget.friendDetails['name'],
            )),
          )
        ],
      ),
    );
  }
}
