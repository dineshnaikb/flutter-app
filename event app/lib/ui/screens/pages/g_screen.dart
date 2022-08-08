import 'package:events/ui/widgets/appbar.dart';
import 'package:events/ui/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:events/core/app_theme.dart';

class GScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
        leading: Icon(Icons.notifications),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/credit_screen'),
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: Icon(Icons.filter)),
          )
        ],
        title: Image.asset(
          Theme.of(context).logo,
          width: 22.0.w,
        ),
        centerTitle: true,
      ),
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text(
                    "Hello, Jessy!",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(
                        fontSize: 21.0.sp, fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text(
                    "What are you in mood of the today?",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(
                        fontSize: 13.0.sp,
                        color: Theme.of(context).feedTextSecondaryColor),
                  )),
              SizedBox(
                height: 3.0.h,
              ),
              Container(
                width: double.infinity,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(211, 237, 241, 1),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/bg.png',
                        ))),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.pushNamed(context, '/create_event');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Create an Event",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                                color: Colors.black,
                                fontSize: 17.0.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text("Join an Event",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w500,
                      ))),
              SizedBox(
                height: 2.5.h,
              ),
              // Container(
              //   height: 26.0.h,
              //   padding: EdgeInsets.only(left: 2.0.w),
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: 5,
              //       itemBuilder: (context, index) {
              //         return EventItem();
              //       }),
              // ),
              SizedBox(
                height: 2.5.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/request_screen');
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                    child: Text("View Requests",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.raleway(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.w500,
                        ))),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Container(
                height: 10.0.h,
                padding: EdgeInsets.only(left: 2.0.w),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GScreenRequestItem();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GScreenRequestItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0.w,
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: 4.0.w,
          ),
          CircleAvatar(),
          SizedBox(
            width: 3.0.w,
          ),
          Container(
            width: 22.0.w,
            child: Text(
              "Jane Cooper",
              style: GoogleFonts.raleway(
                  fontSize: 12.0.sp, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

// class ArcClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, 0);
//     // path.lineTo(-20, size.height / 2);
//     // path.lineTo(-20, size.height);
//     path.quadraticBezierTo(0, 0, -50, -50);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     // TODO: implement shouldReclip
//     return true;
//   }
// }

// class CurvedPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     print(size.width);
//     print(size.height);
//     var paint = Paint();
//     var path = Path();
//     paint.color = Colors.red;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 2.0;
//     path.arcToPoint(Offset(-20, size.height * 0.5),
//         radius: Radius.circular(100), clockwise: false);
//     path.arcToPoint(Offset(-30, size.height),
//         radius: Radius.circular(70), clockwise: true);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return false;
//   }
// }
