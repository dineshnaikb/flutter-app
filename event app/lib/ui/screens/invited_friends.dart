import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/ui/screens/map_screen.dart';
import 'package:events/ui/screens/pages/feed_screen.dart';
import 'package:events/ui/screens/pages/friends_screen.dart';
import 'package:events/ui/screens/pages/g_screen.dart';
import 'package:events/ui/screens/pages/profile_screen.dart';
import 'package:events/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:events/constants.dart';

import '../../bottom_bar_icons.dart';

class InvitedFriends extends StatefulWidget {
  @override
  State<InvitedFriends> createState() => _InvitedFriendsState();
}

class _InvitedFriendsState extends State<InvitedFriends> {
  List invitedFriends = [];
  EventState event = EventState();
  fetchInvitedFriends() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    Response response = await Dio().get(
        'https://nextopay.com/uploop/event_invite?event_id=${event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');
    invitedFriends = json.decode(response.data)['data'].toList();
    setState(() {});
  }

  @override
  void initState() {
    fetchInvitedFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as EventState;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar.build(context, FontAwesomeIcons.filter),
      bottomNavigationBar: buildBottomBar(context),
      extendBody: true,
      body: SafeArea(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text(
                    "Invited Friends",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(fontSize: 25.0.sp),
                  )),
              SizedBox(
                height: 2.0.h,
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: invitedFriends.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          leading: Container(
                              height: double.infinity,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(invitedFriends[index]['pic']),
                              )),
                          title: Text(
                            invitedFriends[index]['name'],
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w500),
                          ),
                          // subtitle: Text(invitedFriends[index]['email']),
                          trailing: InkWell(
                            onTap: () async {
                              final SharedPreferences _prefs =
                                  await SharedPreferences.getInstance();

                              print(_prefs.getString("user_obj"));
                              Response response = await Dio().get(invitedFriends[
                                          index]['status'] ==
                                      "0"
                                  ? 'https://nextopay.com/uploop/invite_friends?event_invite_id=${invitedFriends[index]['evenet_invite_id']}&req_type=1&userid=${_prefs.getString("user_id")}'
                                  : 'https://nextopay.com/uploop/invite_friends?event_invite_id=${invitedFriends[index]['evenet_invite_id']}&req_type=2&userid=${_prefs.getString("user_id")}');
                              print(response.data);

                              fetchInvitedFriends();
                            },
                            child: Icon(
                              FontAwesomeIcons.ban,
                              color: invitedFriends[index]['status'] == "0"
                                  ? Theme.of(context).secondaryBackgroundColor
                                  : Theme.of(context).redColor,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  List<Widget> bottomBarScreen = [
    FeedScreen(),
    MapScreen(),
    GScreen(),
    FriendsScreen(),
    ProfileScreen()
  ];
}
