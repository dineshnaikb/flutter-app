import 'dart:developer';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/friends_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FriendsScreen extends StatefulWidget {
  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
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
              "Friends",
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
          ),
          Flexible(
            child: BlocBuilder<FriendsCubit, FriendsState>(
              builder: (context, state) {
                BlocProvider.of<FriendsCubit>(context).loadFriends();
                if (state is FriendsLoaded) {
                  DateTime date = DateTime.now();
                  List friends =
                      BlocProvider.of<FriendsCubit>(context).listofdata;
                  return ListView.builder(
                      itemCount: friends.length,
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              leading: Container(
                                  height: double.infinity,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(friends[index]['name']),
                                  )),
                              title: Text(
                                friends[index]['name'],
                                style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(friends[index]['email'],
                                  style: GoogleFonts.raleway()),
                              trailing: Container(
                                margin: EdgeInsets.only(left: 20),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(37, 144, 83, 1),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Verified",
                                  style:
                                      GoogleFonts.raleway(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
                log(BlocProvider.of<FriendsCubit>(context)
                    .listofdata
                    .length
                    .toString());
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
