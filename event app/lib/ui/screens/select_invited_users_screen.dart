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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:events/constants.dart';

import '../../bottom_bar_icons.dart';

class SelectInvitedUsersScreen extends StatefulWidget {
  @override
  State<SelectInvitedUsersScreen> createState() =>
      _SelectInvitedUsersScreenState();
}

class _SelectInvitedUsersScreenState extends State<SelectInvitedUsersScreen> {
  List allFriends = [];
  EventState event = EventState();
  fetchAllFriends() async {
    currentInvitedList =
        context.read<EventBloc>().state.invitedFriends.toList(growable: true);
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    // print(context.watch<EventBloc>().state.coShareList);
    print(_prefs.getString("user_obj"));
    Response response = await Dio().get(
        'https://nextopay.com/uploop/friends?userid=${json.decode(_prefs.getString("user_obj")!)['user_id']}');
    allFriends = json.decode(response.data)['data'].toList();
    setState(() {});
  }

  List currentInvitedList = [];
  @override
  void initState() {
    fetchAllFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // event = ModalRoute.of(context)!.settings.arguments as EventState;
    return WillPopScope(
      onWillPop: () async {
        currentInvitedList.forEach((element) {
          context
              .read<EventBloc>()
              .add(EventToggleUserInInvitedList(user: element));
        });
        return true;
      },
      child: Scaffold(
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
                Builder(
                  builder: (context) {
                    print(currentInvitedList);
                    return Flexible(
                      child: ListView.builder(
                          itemCount: allFriends.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                leading: Container(
                                    height: double.infinity,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          allFriends[index]['pic']),
                                    )),
                                title: Text(
                                  allFriends[index]['name'],
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(allFriends[index]['email']),
                                trailing: InkWell(
                                  onTap: () async {
                                    // print(
                                    //     context.watch<EventBloc>().state.coShareList);
                                    setState(() {});
                                    if (currentInvitedList
                                        .contains(allFriends[index]['user_id']))
                                      currentInvitedList.removeWhere(
                                          (element) =>
                                              element ==
                                              allFriends[index]['user_id']);
                                    else
                                      currentInvitedList
                                          .add(allFriends[index]['user_id']);
                                    // context.watch<EventBloc>().add(
                                    //     EventToggleUserInCoshareList(
                                    //         user: allFriends[index]['user_id']));

                                    // fetchAllFriends();
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.checkCircle,
                                    color: !currentInvitedList.contains(
                                            allFriends[index]['user_id'])
                                        ? Theme.of(context)
                                            .secondaryBackgroundColor
                                        : Colors.green,
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
