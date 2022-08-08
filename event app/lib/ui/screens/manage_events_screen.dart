import 'dart:ui';

import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/bloc/event_display_bloc.dart';

class ManageEventsScreen extends StatelessWidget {
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
              "Manage Events",
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Builder(builder: (context) {
            List<EventState> events = [];

            events = context
                .watch<EventDisplayBloc>()
                .state
                .my_events
                .where((element) =>
                    element.uid != context.read<SettingsBloc>().state.uid)
                .toList();
            return Flexible(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return MyEventItem(
                      event: events[index],
                    );
                  }),
            );
          })
        ],
      ),
    );
  }
}

void show(BuildContext context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      context: context,
      // backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).sheetColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            height: 25.0.h,
            child: Column(
              children: [
                SizedBox(
                  height: 4.0.h,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            backgroundColor:
                                Theme.of(context).secondaryBackgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            content: Container(
                              height: 40.0.h,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Text("Are you sure want cancel the event?",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway(
                                          fontSize: 20.0.sp,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Text("All Guests will be notified",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway()),
                                  SizedBox(
                                    height: 6.0.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () async {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 7.0.h,
                                          width: 60.8.w,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                135, 207, 217, 1),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "Cancel Event",
                                            style: GoogleFonts.raleway(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .textSecondaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () async {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 7.0.h,
                                          width: 60.8.w,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .textPrimaryColor),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "Discard",
                                            style: GoogleFonts.raleway(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .textPrimaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  },
                  child: Container(
                    width: 80.8.w,
                    height: 8.0.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Cancel: Yacht Party in Miami",
                      style: GoogleFonts.raleway(
                          fontSize: 12.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.pushNamed(context, '/modify_event');
                  },
                  child: Container(
                    width: 80.8.w,
                    height: 8.0.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Modify: Yacht Party in Miami",
                      style: GoogleFonts.raleway(
                          fontSize: 12.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

class MyEventItem extends StatelessWidget {
  EventState event;
  MyEventItem({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    print(event.title);
    print(event.event_map['event_status']);
    return event.event_map['event_status'] == 'Cancelled'
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.srcOver),
                    fit: BoxFit.fill,
                    image: NetworkImage(event.img1))),
            margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 1.0.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pushNamed(context, '/manage_event', arguments: event);
              },
              onLongPress: () {
                show(context);
              },
              child: Container(
                height: 30.0.h,
                margin:
                    EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          event.title,
                          style: GoogleFonts.raleway(
                              fontSize: 17.0.sp, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '(Cancelled)',
                          style: GoogleFonts.raleway(
                              fontSize: 17.0.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        Text(
                          event.event_date,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.raleway(
                              fontSize: 12.0.sp, color: Colors.white),
                        ),
                        SizedBox(
                          width: 4.0.w,
                        ),
                        Text(
                          "${event.from_time} - ${event.to_time}",
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
              ),
            ),
          )
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.srcOver),
                    fit: BoxFit.fill,
                    image: NetworkImage(event.img1))),
            margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 1.0.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pushNamed(context, '/manage_event', arguments: event);
              },
              onLongPress: () {
                show(context);
              },
              child: Container(
                height: 30.0.h,
                margin:
                    EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: GoogleFonts.raleway(
                          fontSize: 17.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        Text(
                          event.event_date,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.raleway(
                              fontSize: 12.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                        SizedBox(
                          width: 4.0.w,
                        ),
                        Text(
                          "${event.from_time} - ${event.to_time}",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.raleway(
                              fontSize: 15,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
