import 'dart:convert';
import 'dart:developer';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/event_requests_cubit.dart';
import 'package:events/logic/cubit/friends_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class RequestScreen extends StatelessWidget {
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            alignment: Alignment.centerLeft,
            child: Text(
              "All Requests",
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
          ),
          Flexible(
            child: BlocBuilder<EventRequestsCubit, EventRequestsState>(
              builder: (context, state) {
                BlocProvider.of<EventRequestsCubit>(context).loadFriends();
                if (state is EventRequestsLoaded) {
                  DateTime date = DateTime.now();
                  List friendRequests =
                      BlocProvider.of<EventRequestsCubit>(context).listofdata;
                  log(friendRequests.toString());
                  return ListView.builder(
                      itemCount: friendRequests.length,
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
                                    borderRadius: BorderRadius.circular(30)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                leading: Container(
                                    height: double.infinity,
                                    child: const CircleAvatar()),
                                title: Text(
                                  friendRequests[index]['Name'],
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(friendRequests[index]['Name']),
                                trailing: Container(
                                  width: 15.0.w,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences _prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          var response = await http.get(Uri.parse(
                                              'https://nextopay.com/uploop/accept_request?userid=${_prefs.get('user_id')}&evenet_invite_id=${friendRequests[index]['event_invite_id']}&invite_status=1'));

                                          BlocProvider.of<EventRequestsCubit>(
                                                  context)
                                              .loadFriends();
                                        },
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences _prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          var response = await http.get(Uri.parse(
                                              'https://nextopay.com/uploop/accept_request?userid=${_prefs.get('user_id')}&evenet_invite_id=${friendRequests[index]['event_invite_id']}&invite_status=0'));
                                          print(response.body);
                                          BlocProvider.of<EventRequestsCubit>(
                                                  context)
                                              .loadFriends();
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.ban,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        );
                      });
                }
                log(BlocProvider.of<EventRequestsCubit>(context)
                    .listofdata
                    .length
                    .toString());
                return const Center(child: const CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
