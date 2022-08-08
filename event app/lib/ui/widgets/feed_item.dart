import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:events/logic/bloc/event_display_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';

import '../../logic/bloc/event_display_repository.dart';
import '../../logic/cubit/switch_cubit.dart';

class FeedItem extends StatefulWidget {
  final EventState event;
  final List<EventState> allEvents;
  const FeedItem({
    Key? key,
    required this.event,
    required this.allEvents,
  }) : super(key: key);

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  List<Widget> sponsorsIcons = [];
  List<Widget> eventComments = [
    Text(
      'Comments 0',
      style: GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 3.0.h,
    ),
    Center(
        child:
            SizedBox(height: 50, width: 50, child: CircularProgressIndicator()))
  ];
  bool hitApi = true;
  fetchComments(Function stateSetter) async {
    if (hitApi) {
      print('fetching');
      print(eventComments);
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      print(_prefs.getString("user_obj"));
      print(widget.event.uid);
      print(
          'https://nextopay.com/uploop/event_comments?event_id=${widget.event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');
      Response response = await Dio().get(
          'https://nextopay.com/uploop/event_comments?event_id=${widget.event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');

      log(response.data);
      // if(response.data)
      // log(json.decode(response.data)['data'].toList().toString());
      eventComments.clear();
      if (json.decode(response.data)['data'] != '') {
        json.decode(response.data)['data'].toList().forEach((element) {
          eventComments.add(Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    Expanded(
                        child: FutureBuilder<bool>(
                      builder: (ctx, snapshot) {
                        print(snapshot.data!);
                        // Displaying LoadingSpinner to indicate waiting state
                        return CircleAvatar(
                          minRadius: 6.0.w,
                          backgroundImage: snapshot.data!
                              ? NetworkImage(
                                  '${element['User_detail'].toList()[0]['Pic']}')
                              : const NetworkImage(
                                  'https://nextopay.com/uploop/images/users/user.png'),
                        );
                      },
                      future: File(element['User_detail'].toList()[0]['Pic'])
                          .exists(),
                    )),
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
                //alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0.h,
                    ),
                    rate
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Text(
                            '${element['comment']}',
                            textAlign: TextAlign.start,
                          ),
                        )),
                    SizedBox(
                      height: 1.0.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ));
        });
      }
      eventComments.insert(
          0,
          SizedBox(
            height: 3.0.h,
          ));
      eventComments.insert(
          0,
          Text(
            'Comments ${eventComments.length - 1}',
            style:
                GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
          ));

      stateSetter(() {
        hitApi = false;
      });
      setState(() {});
    } else {
      print('not fetching');
      print(eventComments);
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    if (widget.event.event_map['Sponcers'] != '') {
      for (int i = 0;
          i < widget.event.event_map['Sponcers'].toList().length;
          i++) {
        sponsorsIcons.add(Positioned(
          left: 20.0 * i,
          child: new CircleAvatar(
            backgroundImage: NetworkImage(
              widget.event.event_map['Sponcers'].toList()[i]['pic'],
            ),
            radius: 20,
          ),
        ));
      }
      print(sponsorsIcons);

      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchCubit>(
      create: (context) => SwitchCubit(),
      child: Container(
        height: 60.0.h,
        margin: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      widget.event.event_map['created_by'].toList()[0]
                          ['user_pic']),
                ),
                SizedBox(
                  width: 5.0.w,
                ),
                Text(
                  widget.event.event_map['created_by']
                      .toList()[0]['user_name']
                      .toString(),
                  style: GoogleFonts.raleway(
                      color: Theme.of(context).textPrimaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            InkWell(
              onTap: () async {
                final SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                // print(_prefs.getString("user_id"));
                // print(_prefs.getString("user_obj"));
                print(widget.event.event_map['created_by'].toList()[0]);
                if (widget.event.event_map['created_by'].toList()[0]
                        ['user_id'] ==
                    _prefs.getString("user_id"))
                  Navigator.pushNamed(context, '/event_info',
                      arguments: widget.event);
                else
                  Navigator.pushNamed(context, '/event_details',
                      arguments: widget.event);
              },
              child: SizedBox(
                height: 32.0.h,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Stack(
                  children: [
                    Container(
                        height: 32.0.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(widget.event.img1),
                              fit: BoxFit.fill,
                            ))),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          height: 40,
                          width: 35,
                          // alignment: Alignment(-1.0, -),
                          // color: Colors.red,
                          child: Stack(children: sponsorsIcons)),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.7),
                              child: Icon(
                                Icons.male,
                                color: Color(0xff2D9CDB),
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.event.male_no),
                          SizedBox(
                            width: 12,
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.7),
                              child: Icon(
                                Icons.female,
                                color: Color(0xffFF4A76),
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.event.female_no),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Text(
              widget.event.title,
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
            SizedBox(
              height: 1.8.h,
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
                      widget.event.from_time,
                      style: GoogleFonts.raleway(
                          color: Theme.of(context).feedTextSecondaryColor),
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
                      widget.event.place,
                      style: GoogleFonts.raleway(
                          color: Theme.of(context).feedTextSecondaryColor),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 1.8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, setBottomSheetState) {
                          fetchComments(setBottomSheetState);

                          return Stack(
                            children: [
                              Column(
                                children: [
                                  Spacer(),
                                  Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: ListView(
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Icon(Icons.close)),
                                              Spacer(
                                                flex: 2,
                                              ),
                                              Image.asset(
                                                Theme.of(context).logo,
                                                width: 25.0.w,
                                              ),
                                              Spacer(
                                                flex: 3,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.0.h,
                                          ),
                                          ...eventComments
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.0.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () async {
                                          Navigator.pushNamed(
                                              context, '/write_a_comment',
                                              arguments: widget.event);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 6.0.h,
                                          width: 40.8.w,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                135, 207, 217, 1),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "Write a Comment",
                                            style: GoogleFonts.raleway(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .textSecondaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                      },
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/Comments.svg',
                        color: Theme.of(context).appBarIconColor,
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        "Comments",
                        style: GoogleFonts.raleway(
                            color: Theme.of(context).feedTextSecondaryColor),
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        widget.event.comments,
                        style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () async {
                    if (widget.event.paid_event != true) {
                      final SharedPreferences _prefs =
                          await SharedPreferences.getInstance();

                      print(_prefs.getString("user_obj"));
                      Response response = await Dio().get(
                          'https://nextopay.com/uploop/request_to_join?userid=${_prefs.getString("user_id")}&event_id=${widget.event.uid}');
                      print(response.data);
                      int index = widget.allEvents.indexOf(widget.event);
                      widget.allEvents[index].Request_Status = await "YES";

                      context.read<EventDisplayBloc>().add(
                          EventDiplayRequestedToJoin(
                              newEvents: widget.allEvents));
                    } else
                      Navigator.pushNamed(context, '/event_details',
                          arguments: widget.event);
                    // EventDisplayBloc(
                    //         eventDisplayRepository: eventDisplayRepository)
                    //     .mapEventToState(eventDisplayEvent);
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) => buildPopUp(context));
                    // request to join code here
                  },
                  child: Container(
                    width: 40.0.w,
                    alignment: Alignment.center,
                    height: 5.5.h,
                    decoration: BoxDecoration(
                      color: widget.event.Request_Status == 'NO'
                          ? const Color.fromRGBO(135, 207, 217, 1)
                          : const Color.fromRGBO(78, 80, 82, 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: widget.event.Request_Status == 'NO'
                        ? widget.event.paid_event == true
                            ? Text("Pay to Join",
                                style: GoogleFonts.raleway(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                            : widget.event.virtual_event == true
                                ? Text("Request to Join",
                                    style: GoogleFonts.raleway(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                                : Text("Join Event",
                                    style: GoogleFonts.raleway(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                        : widget.event.virtual_event == true
                            ? Text("Requested",
                                style: GoogleFonts.raleway(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                            : Text("Joined",
                                style: GoogleFonts.raleway(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
