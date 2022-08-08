import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/switch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InboxScreen extends StatelessWidget {
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
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0.w),
              alignment: Alignment.centerLeft,
              child: Text(
                "Inbox",
                style: GoogleFonts.raleway(
                    fontSize: 20.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            CustomSwitch(),
            SizedBox(
              height: 2.0.h,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 5.0.w, vertical: 2.0.h),
                      child: Card(
                        elevation: 0,
                        color: Theme.of(context).notificationListTileColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          leading: Container(
                              height: double.infinity, child: CircleAvatar()),
                          title: Text(
                            "Yacht Party in Miami",
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle:
                              Text("Join us. It will be great to see you"),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.8.h,
      child: ToggleSwitch(
        minWidth: 44.0.w,
        cornerRadius: 100.0,
        activeBgColors: [
          [Theme.of(context).activeColor],
          [Theme.of(context).activeColor],
        ],
        initialLabelIndex: context.watch<SwitchCubit>().state.counter,
        radiusStyle: true,
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
        inactiveBgColor: Theme.of(context).indicator_color,
        totalSwitches: 2,
        labels: ['Current Events', 'Previous Events'],
        onToggle: (ind) {
          print('switched to: $ind');

          context.read<SwitchCubit>().change(ind);
        },
      ),
    );
  }
}
