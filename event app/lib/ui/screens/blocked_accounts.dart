import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockedAccounts extends StatelessWidget {
  List blockedAccounts = [];
  @override
  Widget build(BuildContext context) {
    blockedAccounts = ModalRoute.of(context)!.settings.arguments as List;

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
              "Blocked Accounts",
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: blockedAccounts.length,
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        leading: Container(
                            height: double.infinity,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(blockedAccounts[index]['name']),
                            )),
                        title: Text(
                          blockedAccounts[index]['name'],
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(blockedAccounts[index]['email'],
                            style: GoogleFonts.raleway()),
                        // trailing: Container(
                        //   margin: EdgeInsets.only(left: 20),
                        //   padding: EdgeInsets.all(10),
                        //   decoration: BoxDecoration(
                        //       color: Color.fromRGBO(37, 144, 83, 1),
                        //       borderRadius: BorderRadius.circular(30)),
                        //   child: Text(
                        //     "Verified",
                        //     style: GoogleFonts.raleway(color: Colors.white),
                        //   ),
                        // ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
