import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/bloc/event_display_bloc.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:events/logic/cubit/message_cubit.dart';
import 'package:events/logic/cubit/switch_cubit.dart';
import 'package:events/ui/screens/event_announcements_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../logic/cubit/announcements_cubit.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List recentChatsInnerCircle = [];
  List recentChatsGeneral = [];
  fetchChats() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));

    Response response = await Dio().get(
        'https://nextopay.com/uploop/chat_data?chat_type=1&userid=${json.decode(_prefs.getString("user_obj")!)['user_id']}');

    log(response.data);
    if (json.decode(response.data)['data'] != null) {
      log(json.decode(response.data)['data'].toList().toString());
      recentChatsInnerCircle = json.decode(response.data)['data'].toList();
    }
    setState(() {});
  }

  fetchGeneralChats() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));

    Response response = await Dio().get(
        'https://nextopay.com/uploop/chat_data?chat_type=2&userid=${json.decode(_prefs.getString("user_obj")!)['user_id']}');

    log(response.data);
    log(json.decode(response.data)['data'].toList().toString());
    recentChatsGeneral = json.decode(response.data)['data'].toList();
    setState(() {});
  }

  @override
  void initState() {
    fetchChats();
    fetchGeneralChats();
    super.initState();
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
          title: Image.asset(
            Theme.of(context).logo,
            width: 22.0.w,
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            MessageSwitch(),
            SizedBox(
              height: 3.0.h,
            ),
            if (context.watch<MessageCubit>().state is Inbox)
              Flexible(
                child: Column(
                  children: [
                    BlocProvider<SwitchCubit>(
                      create: (context) => SwitchCubit(),
                      child: InboxSwitch(),
                    ),
                    if (context.watch<MessageCubit>().state is InnerCircle)
                      Flexible(
                        child: ListView.builder(
                            itemCount: recentChatsInnerCircle.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0.w, vertical: 1.0.h),
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(
                                          right: 2.0.w,
                                        ),
                                        child: Text(
                                          "Today 16:20",
                                          style: GoogleFonts.raleway(
                                              color: Theme.of(context)
                                                  .feedTextSecondaryColor),
                                        )),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/private_chat',
                                            arguments:
                                                recentChatsInnerCircle[index]);
                                      },
                                      child: Card(
                                        elevation: 0,
                                        color: Theme.of(context)
                                            .notificationListTileColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          leading: Container(
                                              height: double.infinity,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    recentChatsInnerCircle[
                                                        index]['pic']),
                                              )),
                                          title: Text(
                                            recentChatsInnerCircle[index]
                                                ['user_name'],
                                            style: GoogleFonts.raleway(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                              "Join us. It will be great to see you"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    if (context.watch<MessageCubit>().state is InboxGeneral)
                      Flexible(
                        child: ListView.builder(
                            itemCount: recentChatsGeneral.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0.w, vertical: 1.0.h),
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(
                                          right: 2.0.w,
                                        ),
                                        child: Text(
                                          "Today 16:20",
                                          style: GoogleFonts.raleway(
                                              color: Theme.of(context)
                                                  .feedTextSecondaryColor),
                                        )),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/private_chat',
                                            arguments:
                                                recentChatsGeneral[index]);
                                      },
                                      child: Card(
                                        elevation: 0,
                                        color: Theme.of(context)
                                            .notificationListTileColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          leading: Container(
                                              height: double.infinity,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    recentChatsGeneral[index]
                                                        ['pic']),
                                              )),
                                          title: Text(
                                            recentChatsGeneral[index]
                                                ['user_name'],
                                            style: GoogleFonts.raleway(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                              "Join us. It will be great to see you"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    if (context.watch<MessageCubit>().state is InboxRequests)
                      Flexible(
                        child: ListView.builder(
                            itemCount: 0,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      leading: Container(
                                          height: double.infinity,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircleAvatar(),
                                              Positioned(
                                                  bottom: 5,
                                                  right: 2,
                                                  child: index % 2 == 0
                                                      ? Icon(
                                                          Icons.star,
                                                          size: 15,
                                                        )
                                                      : Container(
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      85,
                                                                      204,
                                                                      241,
                                                                      1),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                            Icons.check,
                                                            size: 15,
                                                            color: Colors.black,
                                                          ),
                                                        ))
                                            ],
                                          )),
                                      title: Text(
                                        "Jane Cooper",
                                        style: GoogleFonts.raleway(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text("Today 11:20 am"),
                                      trailing: Container(
                                        width: 15.0.w,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.green,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.ban,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            }),
                      ),
                  ],
                ),
              ),
            if (context.watch<MessageCubit>().state is Announcements)
              Column(
                children: [
                  BlocProvider<SwitchCubit>(
                    create: (context) => SwitchCubit(),
                    child: AnnouncementSwitch(),
                  ),
                ],
              ),
            SizedBox(
              height: 2.0.h,
            ),
            if (context.watch<MessageCubit>().state is PreviousEvents)
              Flexible(
                child: Builder(builder: (context) {
                  List<EventState> events = [];

                  events = context
                      .watch<EventDisplayBloc>()
                      .state
                      .all_events
                      .where((element) =>
                          element.uid !=
                              context.read<SettingsBloc>().state.uid &&
                          element.isCurrEvent == false)
                      .toList();
                  log(events.toString());
                  return Container(
                    height: 26.0.h,
                    padding: EdgeInsets.only(left: 2.0.w),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/manage_event');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.2),
                                          BlendMode.srcOver),
                                      fit: BoxFit.fill,
                                      image: NetworkImage(events[index].img1))),
                              margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                              child: Container(
                                height: 30.0.h,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0.w, vertical: 2.0.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      events[index].title,
                                      style: GoogleFonts.raleway(
                                          fontSize: 17.0.sp,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          events[index].event_date,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                              fontSize: 12.0.sp,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 4.0.w,
                                        ),
                                        Text(
                                          "6:20 pm - 3:00 am",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                              fontSize: 15,
                                              color: Colors.white),
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
                        }),
                  );
                }),
              ),

            // BlocBuilder<MessageCubit, MessageState>(
            //   builder: (context, state) {
            //     if (state is LoadingPreviousEventsState) {
            //       print('LoadingPreviousEventsState');
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (state is ErrorPreviousEventsState) {
            //       print('ErrorPreviousEventsState');
            //       return Center(
            //         child: Icon(Icons.close),
            //       );
            //     } else if (state is LoadedPreviousEventsState) {
            //       final movies = state.previousEventsAnnouncements;
            //       print('LoadedPreviousEventsState');
            //       return ListView.builder(
            //           itemCount: movies.length,
            //           itemBuilder: (context, index) => InkWell(
            //                 onTap: () {
            //                   Navigator.pushNamed(context, '/manage_event');
            //                 },
            //                 child: Container(
            //                   width: double.infinity,
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(20),
            //                       image: DecorationImage(
            //                           colorFilter: ColorFilter.mode(
            //                               Colors.black.withOpacity(0.2),
            //                               BlendMode.srcOver),
            //                           fit: BoxFit.fill,
            //                           image: AssetImage("assets/img.png"))),
            //                   margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            //                   child: InkWell(
            //                     borderRadius: BorderRadius.circular(20),
            //                     onLongPress: () {},
            //                     child: Container(
            //                       height: 30.0.h,
            //                       margin: EdgeInsets.symmetric(
            //                           horizontal: 5.0.w, vertical: 2.0.h),
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.end,
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           RatingBarIndicator(
            //                             rating: 2.75,
            //                             itemBuilder: (context, index) => Icon(
            //                               Icons.star,
            //                               color: Colors.amber,
            //                             ),
            //                             itemCount: 5,
            //                             itemSize: 20.0,
            //                           ),
            //                           SizedBox(
            //                             height: 2.0.h,
            //                           ),
            //                           Text(
            //                             movies[index].name!,
            //                             style: GoogleFonts.raleway(
            //                                 fontSize: 17.0.sp,
            //                                 color: Colors.white),
            //                           ),
            //                           SizedBox(
            //                             height: 2.0.h,
            //                           ),
            //                           Row(
            //                             children: [
            //                               Text(
            //                                 "17 July",
            //                                 textAlign: TextAlign.left,
            //                                 style: GoogleFonts.raleway(
            //                                     fontSize: 12.0.sp,
            //                                     color: Colors.white),
            //                               ),
            //                               SizedBox(
            //                                 width: 4.0.w,
            //                               ),
            //                               Text(
            //                                 "6:20 pm - 3:00 am",
            //                                 textAlign: TextAlign.left,
            //                                 style: GoogleFonts.raleway(
            //                                     fontSize: 15,
            //                                     color: Colors.white),
            //                               ),
            //                             ],
            //                           ),
            //                           SizedBox(
            //                             height: 2.0.h,
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ));
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
            // Flexible(
            //   child: ListView.builder(
            //       itemCount: 7,
            //       itemBuilder: (context, index) {
            //         return InkWell(
            //           onTap: () {
            //             Navigator.pushNamed(context, '/manage_event');
            //           },
            //           child: Container(
            //             width: double.infinity,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(20),
            //                 image: DecorationImage(
            //                     colorFilter: ColorFilter.mode(
            //                         Colors.black.withOpacity(0.2),
            //                         BlendMode.srcOver),
            //                     fit: BoxFit.fill,
            //                     image: AssetImage("assets/img.png"))),
            //             margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            //             child: InkWell(
            //               borderRadius: BorderRadius.circular(20),
            //               onLongPress: () {},
            //               child: Container(
            //                 height: 30.0.h,
            //                 margin: EdgeInsets.symmetric(
            //                     horizontal: 5.0.w, vertical: 2.0.h),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.end,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     RatingBarIndicator(
            //                       rating: 2.75,
            //                       itemBuilder: (context, index) => Icon(
            //                         Icons.star,
            //                         color: Colors.amber,
            //                       ),
            //                       itemCount: 5,
            //                       itemSize: 20.0,
            //                     ),
            //                     SizedBox(
            //                       height: 2.0.h,
            //                     ),
            //                     Text(
            //                       "Night Party in Miami",
            //                       style: GoogleFonts.raleway(
            //                           fontSize: 17.0.sp, color: Colors.white),
            //                     ),
            //                     SizedBox(
            //                       height: 2.0.h,
            //                     ),
            //                     Row(
            //                       children: [
            //                         Text(
            //                           "17 July",
            //                           textAlign: TextAlign.left,
            //                           style: GoogleFonts.raleway(
            //                               fontSize: 12.0.sp,
            //                               color: Colors.white),
            //                         ),
            //                         SizedBox(
            //                           width: 4.0.w,
            //                         ),
            //                         Text(
            //                           "6:20 pm - 3:00 am",
            //                           textAlign: TextAlign.left,
            //                           style: GoogleFonts.raleway(
            //                               fontSize: 15, color: Colors.white),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 2.0.h,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       }),
            // ),
            if (context.watch<MessageCubit>().state is CurrentEvents)
              Flexible(
                child: Builder(builder: (context) {
                  List<EventState> events = [];

                  events = context
                      .watch<EventDisplayBloc>()
                      .state
                      .all_events
                      .where((element) =>
                          element.uid !=
                              context.read<SettingsBloc>().state.uid &&
                          element.isCurrEvent == true)
                      .toList();
                  return Container(
                    height: 26.0.h,
                    padding: EdgeInsets.only(left: 2.0.w),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EventAnnouncementsScreen(
                                              events[index].uid,
                                              events[index].title)));
                              // Navigator.pushNamed(
                              //     context, '/event_announcements');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.2),
                                          BlendMode.srcOver),
                                      fit: BoxFit.fill,
                                      image: NetworkImage(events[index].img1))),
                              margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                              child: Container(
                                height: 30.0.h,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0.w, vertical: 2.0.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // RatingBarIndicator(
                                    //   rating: 2.75,
                                    //   itemBuilder: (context, index) => Icon(
                                    //     Icons.star,
                                    //     color: Colors.amber,
                                    //   ),
                                    //   itemCount: 5,
                                    //   itemSize: 20.0,
                                    // ),
                                    // SizedBox(
                                    //   height: 2.0.h,
                                    // ),
                                    Text(
                                      events[index].title,
                                      style: GoogleFonts.raleway(
                                          fontSize: 17.0.sp,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          events[index].event_date,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                              fontSize: 12.0.sp,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 4.0.w,
                                        ),
                                        Text(
                                          "${events[index].from_time} - ${events[index].to_time}",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.raleway(
                                              fontSize: 15,
                                              color: Colors.white),
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
                        }),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}

class AnnouncementSwitch extends StatelessWidget {
  const AnnouncementSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 40.0.w,
      cornerRadius: 100.0,
      fontSize: 16.0,
      initialLabelIndex: context.read<SwitchCubit>().state.counter,
      radiusStyle: true,
      activeBgColor: [Theme.of(context).activeColor],
      activeFgColor: Theme.of(context).switchColor,
      inactiveBgColor: Theme.of(context).toggleColor,
      inactiveFgColor: Theme.of(context).textPrimaryColor,
      totalSwitches: 2,
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
      labels: ['Previous Events', 'Current Events'],
      onToggle: (index) {
        context.read<SwitchCubit>().change(index);
        if (index == 0) {
          context.read<MessageCubit>().changeStatetoPreviousEvents();
        }
        if (index == 1) {
          context.read<MessageCubit>().changeStatetoCurrentEvents();
        }
      },
    );
  }
}

class InboxSwitch extends StatelessWidget {
  const InboxSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 30.0.w,
      cornerRadius: 100.0,
      fontSize: 16.0,
      initialLabelIndex: context.read<SwitchCubit>().state.counter,
      radiusStyle: true,
      activeBgColor: [Theme.of(context).activeColor],
      activeFgColor: Theme.of(context).switchColor,
      inactiveBgColor: Theme.of(context).toggleColor,
      inactiveFgColor: Theme.of(context).textPrimaryColor,
      totalSwitches: 3,
      labels: ['Inner Circle', 'General', 'Requests'],
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
                fontWeight: FontWeight.w300),
        context.watch<SwitchCubit>().state.counter == 2
            ? GoogleFonts.raleway(
                color: Theme.of(context).switchColor,
                fontWeight: FontWeight.w700)
            : GoogleFonts.raleway(
                color: Theme.of(context).textPrimaryColor,
                fontWeight: FontWeight.w300)
      ],
      onToggle: (index) {
        if (index == 0) {
          context.read<MessageCubit>().changeStatetoInnerCircle();
        }
        if (index == 1) {
          context.read<MessageCubit>().changeStatetoGeneral();
        }
        if (index == 2) {
          context.read<MessageCubit>().changeStatetoRequests();
        }
        context.read<SwitchCubit>().change(index);
      },
    );
  }
}

class MessageSwitch extends StatelessWidget {
  const MessageSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 5.5.h,
      child: ToggleSwitch(
        minWidth: 40.0.w,
        cornerRadius: 100.0,
        fontSize: 16.0,
        initialLabelIndex: context.read<SwitchCubit>().state.counter,
        radiusStyle: true,
        activeBgColor: [Theme.of(context).activeColor],
        activeFgColor: Theme.of(context).switchColor,
        inactiveBgColor: Theme.of(context).toggleColor,
        inactiveFgColor: Theme.of(context).textPrimaryColor,
        totalSwitches: 2,
        labels: [
          'Inbox',
          'Announcements',
        ],
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
        onToggle: (index) {
          print('switched to: $index');
          if (index == 1) {
            context.read<SwitchCubit>().change(index);
            context.read<MessageCubit>().changeStatetoPreviousEvents();
          }
          if (index == 0) {
            context.read<SwitchCubit>().change(index);

            context.read<MessageCubit>().changeStatetoInnerCircle();
            print("object");
          }
        },
      ),
    );
  }
}
