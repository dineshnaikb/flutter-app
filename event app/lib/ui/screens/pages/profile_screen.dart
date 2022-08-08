import 'dart:ui';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/bloc/event_display_bloc.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:events/ui/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:events/core/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../logic/cubit/friends_cubit.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: Container(
            height: 70.0.h,
            color: Theme.of(context).profileBottomSheetColor,
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 8.0,
                  sigmaY: 8.0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).appBarIconColor,
                          )),
                    ),
                    Container(
                      width: 60.0.w,
                      child: Text(
                        "FEB 21, 6:00 PM",
                        style: GoogleFonts.raleway(
                            fontSize: 15.0.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      width: 60.0.w,
                      child: Text(
                        "YACHT PARTY IN MIAMI",
                        style: GoogleFonts.raleway(
                            fontSize: 20.0.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Container(
                      width: 60.0.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: QrImage(
                          data: "1234567890",
                          version: QrVersions.auto,
                          size: 250.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  String fbLink = 'http://', instaLink = 'http://', linkedInLink = 'http://';
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<FriendsCubit>(context).loadFriends();
    setState(() {});

    super.initState();
  }

  void _launchUrl(String link) async {
    final Uri _url = Uri.parse(link);

    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    print("Image URL");
    print(context.watch<SettingsBloc>().state.imageUrl);
    fbLink = 'http://${context.watch<SettingsBloc>().state.facebook}';
    print(fbLink);
    instaLink = 'http://${context.watch<SettingsBloc>().state.instagram}';
    linkedInLink = linkedInLink + context.watch<SettingsBloc>().state.linkedin;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/inbox_screen');
                    },
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/settings_screen');
                        },
                        child: SvgPicture.asset(
                          'assets/Settings.svg',
                          color: Theme.of(context).appBarIconColor,
                        ))))
          ],
          title: Image.asset(
            Theme.of(context).logo,
            width: 22.0.w,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/my_events_screen');
                },
                child: SvgPicture.asset(
                  'assets/Notifications.svg',
                  color: Theme.of(context).appBarIconColor,
                )),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                InkWell(
                  onTap: () {
                    // show(context);

                    Navigator.pushNamed(context, '/main_screen');
                  },
                  child: Container(
                    child: CircleAvatar(
                      radius: 15.0.w,
                      backgroundImage:
                          context.watch<SettingsBloc>().state.imageUrl != ""
                              ? NetworkImage(
                                  context.watch<SettingsBloc>().state.imageUrl)
                              : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                if (context.watch<SettingsBloc>().state.firstname == '' &&
                    context.watch<SettingsBloc>().state.lastname == '')
                  Text(
                    "Anonymous",
                    style: GoogleFonts.raleway(fontSize: 14.0.sp),
                  ),
                if (context.watch<SettingsBloc>().state.firstname != '' ||
                    context.watch<SettingsBloc>().state.lastname != '')
                  Text(
                    context.watch<SettingsBloc>().state.firstname +
                        " " +
                        context.watch<SettingsBloc>().state.lastname,
                    style: GoogleFonts.raleway(
                        fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                  ),
                SizedBox(
                  height: 4.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).secondaryBackgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'FRIENDS',
                              style: GoogleFonts.raleway(),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          BlocProvider.of<FriendsCubit>(context)
                              .listofdata
                              .length
                              .toString(),
                          style: GoogleFonts.raleway(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).secondaryBackgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'HOSTED EVENTS',
                              style: GoogleFonts.raleway(),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          context
                              .watch<EventDisplayBloc>()
                              .state
                              .all_events
                              .where((element) =>
                                  element.uid !=
                                  context.read<SettingsBloc>().state.uid)
                              .toList()
                              .length
                              .toString(),
                          style: GoogleFonts.raleway(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).secondaryBackgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'TRAVEL',
                              style: GoogleFonts.raleway(),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.watch<SettingsBloc>().state.travel,
                          style: GoogleFonts.raleway(),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchUrl(fbLink);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryBackgroundColor,
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            FontAwesomeIcons.facebookF,
                            color: Color.fromRGBO(106, 157, 252, 1),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(instaLink);
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryBackgroundColor,
                              shape: BoxShape.circle),
                          child: Icon(
                            FontAwesomeIcons.instagram,
                            color: Color.fromRGBO(106, 157, 252, 1),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(linkedInLink);
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryBackgroundColor,
                              shape: BoxShape.circle),
                          child: Icon(
                            FontAwesomeIcons.linkedinIn,
                            color: Color.fromRGBO(114, 184, 244, 1),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                Container(
                  child: Text(
                    context.watch<SettingsBloc>().state.bio == ''
                        ? "Hello, I am new here !"
                        : context.watch<SettingsBloc>().state.bio,
                    style: GoogleFonts.raleway(
                        color: Theme.of(context).feedTextSecondaryColor),
                  ),
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                Builder(builder: (context) {
                  List<String> interets =
                      context.watch<SettingsBloc>().state.interests.toList();
                  List<Map> types = context
                      .watch<SettingsBloc>()
                      .state
                      .Current_event
                      .toList();
                  List<Map> movies = context
                      .watch<SettingsBloc>()
                      .state
                      .Previous_event
                      .toList();

                  List<String> foods =
                      context.watch<SettingsBloc>().state.food.toList();

                  List<String> sports =
                      context.watch<SettingsBloc>().state.sports.toList();

                  interets.addAll(foods);
                  interets.addAll(sports);

                  List<Widget> tags =
                      interets.map((e) => ProfileTag(tag: e)).toList();
                  return Wrap(
                      spacing: 2.0.w, runSpacing: 2.0.h, children: tags);
                }),
                SizedBox(
                  height: 4.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Text("Payment Method",
                            style: GoogleFonts.raleway(fontSize: 14.0.sp)),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          width: 30.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(Icons.credit_card_outlined),
                              Icon(FontAwesomeIcons.bitcoin),
                              Icon(FontAwesomeIcons.paypal),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("Profile",
                            style: GoogleFonts.raleway(fontSize: 14.0.sp)),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Text("Personal",
                            style: GoogleFonts.raleway(
                                fontSize: 10.0.sp,
                                color:
                                    Theme.of(context).feedTextSecondaryColor)),
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
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Current Events",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.raleway(
                              fontSize: 14.0.sp, fontWeight: FontWeight.w500),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/manage_events_screen');
                        },
                        child: SvgPicture.asset(
                          'assets/Edit.svg',
                          color: Theme.of(context).appBarIconColor,
                        ))
                  ],
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Builder(builder: (context) {
                  List<EventState> events = [];

                  events = context
                      .watch<EventDisplayBloc>()
                      .state
                      .all_events
                      .where((element) =>
                          element.uid != context.read<SettingsBloc>().state.uid)
                      .toList();
                  return Container(
                    height: 26.0.h,
                    padding: EdgeInsets.only(left: 2.0.w),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return EventItem(
                            event: events[index],
                          );
                        }),
                  );
                }),
                SizedBox(
                  height: 4.0.h,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Previous Events",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                          fontSize: 14.0.sp, fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  height: 2.0.h,
                ),
                Builder(builder: (context) {
                  List<EventState> events = [];

                  events = context
                      .watch<EventDisplayBloc>()
                      .state
                      .all_events
                      .where((element) =>
                          element.uid != context.read<SettingsBloc>().state.uid)
                      .toList();
                  return Container(
                    height: 26.0.h,
                    padding: EdgeInsets.only(left: 2.0.w),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return EventItem(
                            event: events[index],
                          );
                        }),
                  );
                }),
                SizedBox(
                  height: 12.0.h,
                ),
              ],
            ),
          ),
        ));
  }
}

class ProfileTag extends StatelessWidget {
  final String tag;
  ProfileTag({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 20.0.w,
      height: 5.0.h,
      decoration: BoxDecoration(
          color: Theme.of(context).textFieldColor,
          borderRadius: BorderRadius.circular(30)),
      child: Text('#${tag.trim()}', style: GoogleFonts.raleway()),
    );
  }
}
