import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SecurityScreen extends StatelessWidget {
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Text(
              "Security",
              style: GoogleFonts.raleway(
                  fontSize: 20.0.sp, color: Theme.of(context).textPrimaryColor),
            ),
            SizedBox(
              height: 4.0.h,
            ),
            Container(
                child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem vulputate enim sem nisl aliquet. Commodo purus placerat magnis iaculis aliquam, elit amet ipsum. Nullam ut amet, fermentum justo nec. Vulputate quam sed mauris mauris ut eget vitae semper. Lectus blandit viverra venenatis molestie venenatis ipsum arcu sem. Risus neque, sodales risus et morbi viverra pretium. Adipiscing iaculis felis netus tempus, sociis at pretium convallis tortor. Sagittis, cum fames sollicitudin iaculis sed. Sit eros, facilisi adipiscing proin. Ultrices nunc mus ultrices at sed et massa adipiscing cum. Risus dui consequat posuere id elit. Dictum massa iaculis ac sagittis. Mi tempor enim ac quis arcu, mauris ac amet accumsan. Ante nibh est sit egestas. Id.",
              style: GoogleFonts.raleway(
                  fontSize: 12.0.sp,
                  color: Theme.of(context).feedTextSecondaryColor),
            ))
          ],
        ),
      ),
    );
  }
}
