import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:events/logic/bloc/event_bloc.dart';

class EventItem extends StatelessWidget {
  EventState event;
  EventItem({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/event_info', arguments: event);
      },
      child: Container(
          width: 45.0.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.srcOver),
                  fit: BoxFit.fill,
                  image: NetworkImage(event.img1))),
          margin: EdgeInsets.symmetric(horizontal: 2.0.w),
          child: Container(
            height: 30.0.h,
            margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.raleway(
                      fontSize: 15.0.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 1.0.h,
                ),
                Text(
                  event.event_date,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.raleway(fontSize: 15, color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
