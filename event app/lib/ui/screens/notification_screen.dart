import 'dart:developer';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.pushNamed(context, '/main_screen');
                  },
                  child: Icon(
                    FontAwesomeIcons.ellipsisV,
                    color: Theme.of(context).appBarIconColor,
                  ),
                ))
          ],
          title: Image.asset(
            Theme.of(context).logo,
            width: 22.0.w,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Notifications",
                    style: GoogleFonts.raleway(
                        fontSize: 20.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Flexible(
                  child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      BlocProvider.of<NotificationsCubit>(context)
                          .loadNotifications();
                      if (state is NotificationsLoaded) {
                        DateTime date = DateTime.now();

                        return ListView.builder(
                            itemCount:
                                BlocProvider.of<NotificationsCubit>(context)
                                    .listofdata
                                    .length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0.w, vertical: 2.0.h),
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(
                                          right: 2.0.w,
                                        ),
                                        child: Text(
                                          date.toString().substring(0, 10) ==
                                                  BlocProvider.of<
                                                              NotificationsCubit>(
                                                          context)
                                                      .listofdata[index]
                                                      .created_on
                                                      .toString()
                                                      .substring(0, 10)
                                              ? "Today ${BlocProvider.of<NotificationsCubit>(context).listofdata[index].created_on.toString().substring(10)}"
                                              : "${BlocProvider.of<NotificationsCubit>(context).listofdata[index].created_on.toString().substring(0, 16)}",
                                          style: GoogleFonts.raleway(
                                              color: Theme.of(context)
                                                  .feedTextSecondaryColor),
                                        )),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    Card(
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
                                            child: Icon(
                                              FontAwesomeIcons.bell,
                                              color: Color.fromRGBO(
                                                  135, 207, 217, 1),
                                            )),
                                        title: Text(
                                          BlocProvider.of<NotificationsCubit>(
                                                  context)
                                              .listofdata[index]
                                              .name!,
                                          style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Text(
                                            BlocProvider.of<NotificationsCubit>(
                                                    context)
                                                .listofdata[index]
                                                .discription!),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                      log(BlocProvider.of<NotificationsCubit>(context)
                          .listofdata
                          .length
                          .toString());
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
