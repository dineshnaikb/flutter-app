import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CreditDetailsScreen extends StatefulWidget {
  @override
  _CreditDetailsScreenState createState() => _CreditDetailsScreenState();
}

class _CreditDetailsScreenState extends State<CreditDetailsScreen> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text(
                    "Credit Card Details",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(
                        fontSize: 21.0.sp, fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 4.0.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: Theme.of(context).cardBackGroundColor,
                    width: 80.0.w,
                    child: Image.asset(
                      'assets/card.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  hintMaxLines: 2,
                  fillColor: Theme.of(context).textFieldColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25)),
                  hintText: 'Name on Card',
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  hintMaxLines: 2,
                  fillColor: Theme.of(context).textFieldColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25)),
                  hintText: 'Card Number',
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40.0.w,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Theme.of(context).textFieldColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25)),
                        hintText: 'Expiry Date',
                      ),
                    ),
                  ),
                  Container(
                    width: 40.0.w,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Theme.of(context).textFieldColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25)),
                        hintText: 'Security Code',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 8.0.h,
                      width: 80.8.w,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(134, 207, 217, 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Add",
                        style: GoogleFonts.raleway(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
