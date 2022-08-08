// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_display_repository.dart';
import 'package:events/logic/cubit/event_requests_cubit.dart';
import 'package:events/logic/cubit/message_cubit.dart';
import 'package:events/logic/cubit/switch_cubit.dart';
import 'package:events/ui/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../logic/bloc/event_bloc.dart';
import '../../logic/bloc/event_display_bloc.dart';
import '../../logic/bloc/settings_bloc.dart';
import '../widgets/feed_item.dart';

class MainAppScreen extends StatefulWidget {
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  void initState() {
    context.read<EventDisplayBloc>().add(EventDiplayGetUpcommingAndPending());
    setState(() {});
    super.initState();
  }

  void showMenu(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).sheetColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            height: 80.h,
            child: Column(
              children: [
                SizedBox(
                  height: 7.0.h,
                ),
                Container(
                  width: 80.8.w,
                  height: 7.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).textPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Promote Event",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Container(
                  width: 80.8.w,
                  height: 7.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).textPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Promote Video Link",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Container(
                  width: 80.8.w,
                  height: 7.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).textPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Share Event to social networks",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Container(
                  width: 80.8.w,
                  height: 7.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).textPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Set date to publish Event",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Container(
                  width: 80.8.w,
                  height: 7.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).textPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Set Date to remind guests of Event",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Container(
                  width: 80.8.w,
                  height: 7.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).textPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Set a refund policy",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                Container(
                  width: 80.8.w,
                  height: 7.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).textPrimaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Discount and Access codes",
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showPostEventActions(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).sheetColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            height: 40.h,
            child: Column(
              children: [
                SizedBox(
                  height: 7.0.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/promote_screen');
                  },
                  child: Container(
                    width: 80.8.w,
                    height: 7.0.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).textPrimaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Promote",
                      style: GoogleFonts.raleway(
                          fontSize: 14.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/manage_events_screen');
                  },
                  child: Container(
                    width: 80.8.w,
                    height: 7.0.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).textPrimaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Reschedule / Cancel",
                      style: GoogleFonts.raleway(
                          fontSize: 14.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
                InkWell(
                  onTap: () {
                    context.read<MessageCubit>().changeStatetoInnerCircle();

                    Navigator.of(context).pushNamed('/message_screen');
                  },
                  child: Container(
                    width: 80.8.w,
                    height: 7.0.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).textPrimaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Message Guests",
                      style: GoogleFonts.raleway(
                          fontSize: 14.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchCubit>(
        create: (context) => SwitchCubit(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
            elevation: 0,
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {
                        context.read<MessageCubit>().changeStatetoInnerCircle();
                        Navigator.of(context).pushNamed('/message_screen');
                      },
                      child: SvgPicture.asset(
                        'assets/inbox.svg',
                        color: Theme.of(context).appBarIconColor,
                      ))),
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(
                      onTap: () {
                        showMenu(context);
                      },
                      child: Icon(FontAwesomeIcons.ellipsisV)))
            ],
            title: Image.asset(
              Theme.of(context).logo,
              width: 22.0.w,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Text(
                      "Hello, ${context.watch<SettingsBloc>().state.firstname}",
                      style: GoogleFonts.raleway(fontSize: 20.0.sp)),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Text(
                    "What are you in the mood for today?",
                    style: GoogleFonts.raleway(
                        fontSize: 12.0.sp,
                        color: Theme.of(context).feedTextSecondaryColor),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/create_event');
                        },
                        child: Container(
                          width: 25.0.w,
                          height: 15.0.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).textFieldColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline,
                                  size: 25,
                                  color: Color.fromRGBO(134, 158, 215, 1)),
                              SizedBox(height: 1.0.h),
                              Container(
                                width: 20.0.w,
                                child: Text("Create an Event",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway()),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 25.0.w,
                        height: 15.0.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).textFieldColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.exit_to_app,
                                size: 25,
                                color: Color.fromRGBO(114, 177, 132, 1)),
                            SizedBox(height: 1.0.h),
                            Container(
                              width: 20.0.w,
                              child: Text("Join an Event",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway()),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/request_screen');
                        },
                        child: Container(
                          width: 25.0.w,
                          height: 15.0.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).textFieldColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.message,
                                  size: 25,
                                  color: Color.fromRGBO(217, 155, 136, 1)),
                              SizedBox(height: 1.0.h),
                              Container(
                                width: 20.0.w,
                                child: Text("View Requests",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway()),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          showPostEventActions(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 8.0.h,
                          width: 80.8.w,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(135, 207, 217, 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Post event Actions",
                            style: GoogleFonts.raleway(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).textSecondaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Center(child: CustomSwitch()),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Builder(builder: (context) {
                    List<Map> events = [];

                    int counter = context.watch<SwitchCubit>().state.counter;

                    if (counter == 0) {
                      events =
                          context.watch<EventDisplayBloc>().state.upcomming;
                    } else if (counter == 1) {
                      print("xyz");
                      events = context.watch<EventDisplayBloc>().state.pending;
                    }
                    log(events.toString());

                    if (events.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        height: 26.0.h,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              return EventItem(
                                event: events[index],
                              );
                            }),
                      );
                    }
                  }),
                  // Container(
                  //   height: 26.0.h,
                  //   padding: EdgeInsets.only(left: 2.0.w),
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: 5,
                  //       itemBuilder: (context, index) {
                  //         return EventItem(event: null,);
                  //       }),
                  // ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Container(
                    child: Text(
                      "View Requests",
                      style: GoogleFonts.raleway(fontSize: 12.0.sp),
                    ),
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  BlocBuilder<EventRequestsCubit, EventRequestsState>(
                    builder: (context, state) {
                      BlocProvider.of<EventRequestsCubit>(context)
                          .loadFriends();
                      if (state is EventRequestsLoaded) {
                        DateTime date = DateTime.now();
                        List friendRequests =
                            BlocProvider.of<EventRequestsCubit>(context)
                                .listofdata;

                        return Container(
                          height: 11.0.h,
                          padding: EdgeInsets.only(left: 2.0.w),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: friendRequests.length,
                              itemBuilder: (context, index) {
                                return InvitedListItem(friendRequests[index]);
                              }),
                        );
                      }
                      log(BlocProvider.of<EventRequestsCubit>(context)
                          .listofdata
                          .length
                          .toString());
                      return const Center(
                          child: const CircularProgressIndicator());
                    },
                  ),

                  SizedBox(
                    height: 12.0.h,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

EventState eventDetails = EventState();
fetchEventDetails(String eventId) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();

  print(_prefs.getString("user_obj"));
  log('https://nextopay.com/uploop/event_detail?userid=${_prefs.getString("user_id")}&event_id=${eventId}');
  Response response = await Dio().get(
      'https://nextopay.com/uploop/event_detail?userid=${_prefs.getString("user_id")}&event_id=${eventId}');

  eventDetails =
      await EventState.fromMap(json.decode(response.data)['data'].toList()[0]);
  print(eventDetails);
}

class EventItem extends StatelessWidget {
  Map event;
  EventItem({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await fetchEventDetails(event['event_id']);
        Navigator.pushNamed(context, '/event_details_without_payments',
            arguments: eventDetails);
      },
      child: Container(
          width: 45.0.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.srcOver),
                  fit: BoxFit.fill,
                  image: NetworkImage(event['pic']))),
          margin: EdgeInsets.symmetric(horizontal: 2.0.w),
          child: Container(
            height: 30.0.h,
            margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['name'].toString(),
                  style: GoogleFonts.raleway(
                      fontSize: 15.0.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 1.0.h,
                ),
                Text(
                  event['Date'].toString(),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.raleway(fontSize: 15, color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}

class InvitedListItem extends StatelessWidget {
  Map requestDetails = {};
  InvitedListItem(this.requestDetails);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
      alignment: Alignment.center,
      width: 20.0.w,
      height: 4.0.h,
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.0.h,
          ),
          CircleAvatar(
            minRadius: 6.0.w,
            backgroundImage: NetworkImage(requestDetails['Pic']),
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Center(
            child: Container(
                width: 25.0.w,
                child: Text(
                  requestDetails['Name'],
                  style: GoogleFonts.raleway(),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                )),
          ),
          SizedBox(
            height: 1.0.h,
          ),
        ],
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.8.h,
      child: ToggleSwitch(
        minWidth: 40.0.w,
        cornerRadius: 100.0,
        activeBgColors: [
          [Theme.of(context).activeColor],
          [Theme.of(context).activeColor],
        ],
        initialLabelIndex: context.watch<SwitchCubit>().state.counter,
        radiusStyle: true,
        customTextStyles: [
          context.watch<SwitchCubit>().state.counter == 0
              ? GoogleFonts.raleway(
                  color: Theme.of(context).switchColor,
                  fontWeight: FontWeight.w700)
              : GoogleFonts.raleway(
                  color: Theme.of(context).textPrimaryColor,
                  fontWeight: FontWeight.w300),
          context.watch<SwitchCubit>().state.counter == 1
              ? GoogleFonts.raleway(
                  color: Theme.of(context).switchColor,
                  fontWeight: FontWeight.w700)
              : GoogleFonts.raleway(
                  color: Theme.of(context).textPrimaryColor,
                  fontWeight: FontWeight.w300)
        ],
        inactiveBgColor: Theme.of(context).indicator_color,
        totalSwitches: 2,
        labels: ['Upcoming Events', 'Pending Events'],
        onToggle: (ind) {
          print('switched to: $ind');

          context.read<SwitchCubit>().change(ind);
        },
      ),
    );
  }
}
