import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ManageEventScreen extends StatelessWidget {
  GlobalKey scaffKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    EventState event = ModalRoute.of(context)!.settings.arguments as EventState;

    return Scaffold(
      key: scaffKey,
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.0.h,
              ),
              Text(
                "Manage Event",
                textAlign: TextAlign.start,
                style: GoogleFonts.raleway(
                    fontSize: 17.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Text(
                event.title,
                textAlign: TextAlign.start,
                style: GoogleFonts.raleway(
                    fontSize: 18.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              // Wrap(
              //   spacing: 2.0.w,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.all(12),
              //       decoration: BoxDecoration(
              //           color: Theme.of(context).textFieldColor,
              //           borderRadius: BorderRadius.circular(30)),
              //       child: Text("Crypto"),
              //     ),
              //     Container(
              //       padding: EdgeInsets.all(12),
              //       decoration: BoxDecoration(
              //           color: Theme.of(context).textFieldColor,
              //           borderRadius: BorderRadius.circular(30)),
              //       child: Text("Crypto"),
              //     ),
              //     Container(
              //       padding: EdgeInsets.all(12),
              //       decoration: BoxDecoration(
              //           color: Theme.of(context).textFieldColor,
              //           borderRadius: BorderRadius.circular(30)),
              //       child: Text("Crypto"),
              //     )
              //   ],
              // ),

              Container(
                  height: 28.0.h,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: Theme.of(context).feedTextSecondaryColor),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        "${event.event_date}, ${event.from_time}",
                        style: GoogleFonts.raleway(
                            color: Theme.of(context).feedTextSecondaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_pin,
                          color: Theme.of(context).feedTextSecondaryColor),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        "${event.place}",
                        style: GoogleFonts.raleway(
                            color: Theme.of(context).feedTextSecondaryColor),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                child: Text(
                  "\$${event.female_price}",
                  style: GoogleFonts.raleway(fontSize: 17.0.sp),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                height: 30.0.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    backgroundColor: Theme.of(context)
                                        .secondaryBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    content: Container(
                                      height: 40.0.h,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 2.0.h,
                                          ),
                                          Text(
                                              "Are you sure want cancel the event?",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.raleway(
                                                  fontSize: 20.0.sp,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 2.0.h,
                                          ),
                                          Text(
                                            "All Guests will be notified",
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 6.0.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                onTap: () async {
                                                  final SharedPreferences
                                                      _prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  // print(_prefs.getString("user_id"));
                                                  // print(_prefs.getString("user_obj"));
                                                  Response response =
                                                      await Dio().post(
                                                          'https://nextopay.com/uploop/cancel_event?event_id=${event.uid}&userid=${_prefs.getString("user_id")}');
                                                  print(response.data);
                                                  if (json.decode(response
                                                          .data)['status'] ==
                                                      "1") {
                                                    Navigator.pop(context);

                                                    ScaffoldMessenger.of(scaffKey
                                                            .currentContext!)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Event cancelled successfully')));
                                                  } else {
                                                    Navigator.pop(context);

                                                    ScaffoldMessenger.of(scaffKey
                                                            .currentContext!)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                'Event is already cancelled')));
                                                  }
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 7.0.h,
                                                  width: 60.8.w,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        135, 207, 217, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Text(
                                                    "Cancel Event",
                                                    style: GoogleFonts.raleway(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 7.0.h,
                                                  width: 60.8.w,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .textPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Text(
                                                    "Discard",
                                                    style: GoogleFonts.raleway(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                            alignment: Alignment.center,
                            height: 7.0.h,
                            width: 80.8.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Cancel Event",
                              style: GoogleFonts.raleway(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).textPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () async {
                            context
                                .read<EventBloc>()
                                .add(EventEditInitial(eventToEdit: event));
                            // context.read<EventBloc>().add(EventEditInitial(eventToEdit: eventToEdit));
                            Navigator.pushNamed(context, '/modify_event',
                                arguments: event);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 7.0.h,
                            width: 80.8.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Modify Event",
                              style: GoogleFonts.raleway(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).textPrimaryColor),
                            ),
                          ),
                        ),
                      ],
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
                            width: 80.8.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Promote Event",
                              style: GoogleFonts.raleway(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).textPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPopUp(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
          height: 50.0.h,
          child: Column(
            children: [
              Container(
                height: 15.0.h,
                child: Image.asset(
                  'assets/congratulations.png',
                  width: 20.0.w,
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                height: 4.0.h,
                child: Text(
                  "Congratulations!",
                  style: GoogleFonts.raleway(fontSize: 20.0.sp),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              // Container(
              //   height: 7.0.h,
              //   child: Text(
              //     "Your event has been\ncancelled created",
              //     textAlign: TextAlign.center,
              //     style: GoogleFonts.raleway(
              //         color: Theme.of(context).feedTextSecondaryColor),
              //   ),
              // ),
              //
              // SizedBox(
              //   height: 2.0.h,
              // ),
              //
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Navigator.of(context).pop();

                  // Navigator.pushNamed(context, '/event_info', arguments: event);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 6.5.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(135, 207, 217, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Done",
                    style: GoogleFonts.raleway(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
