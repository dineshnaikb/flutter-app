import 'dart:io';
import 'dart:ui';
import 'package:events/core/app_theme.dart';
import 'package:events/ui/screens/myevents_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:sizer/sizer.dart';

class PromoteScreen extends StatelessWidget {
  show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 100),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Theme.of(context).profileBottomSheetColor,
          body: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 80.0.w,
                          child: Text(
                            "Rate, Jenny",
                            style: GoogleFonts.raleway(fontSize: 20.0.sp),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(child: Icon(Icons.close)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.0.h,
                    ),
                    CircleAvatar(
                      radius: 40,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(
                      "Jenny Wilson",
                      style: GoogleFonts.raleway(fontSize: 15.0.sp),
                    ),
                    SizedBox(
                      height: 8.0.h,
                    ),
                    Text(
                      "YACHT PARTY IN MIAMI",
                      style: GoogleFonts.raleway(fontSize: 22.0.sp),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(
                      "FEB 21, 6:00 PM",
                      style: GoogleFonts.raleway(fontSize: 18.0.sp),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Theme.of(context).textFieldColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25)),
                        hintText: 'Comment',
                      ),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () async {},
                          child: Container(
                            alignment: Alignment.center,
                            height: 8.0.h,
                            width: 80.8.w,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(135, 207, 217, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Rate",
                              style: GoogleFonts.raleway(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).textSecondaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [RatingItem(), RatingItem(), RatingItem()],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
              Text(
                "Promote",
                style: GoogleFonts.raleway(
                    fontSize: 20.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              CustomImageContainer(),
              SizedBox(
                height: 2.0.h,
              ),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  filled: true,
                  fillColor: Theme.of(context).textFieldColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25)),
                  hintText: 'Description',
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Text(
                "Share with socials",
                style: GoogleFonts.raleway(
                    fontSize: 15.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 20.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RoundCheckBox(
                                  border: Border.all(width: 0),
                                  uncheckedWidget: Container(
                                    color: Color.fromRGBO(42, 42, 42, 1),
                                    child: Icon(
                                      Icons.check,
                                      size: 20,
                                    ),
                                  ),
                                  size: 30,
                                  onTap: (val) {})
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).textFieldColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              FontAwesomeIcons.facebookF,
                              size: 20,
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 20.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RoundCheckBox(
                                  border: Border.all(width: 0),
                                  uncheckedWidget: Container(
                                    color: Color.fromRGBO(42, 42, 42, 1),
                                    child: Icon(
                                      Icons.check,
                                      size: 20,
                                    ),
                                  ),
                                  size: 30,
                                  onTap: (val) {})
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).textFieldColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              size: 20,
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 20.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RoundCheckBox(
                                  border: Border.all(width: 0),
                                  uncheckedWidget: Container(
                                    color: Color.fromRGBO(42, 42, 42, 1),
                                    child: Icon(
                                      Icons.check,
                                      size: 20,
                                    ),
                                  ),
                                  size: 30,
                                  onTap: (val) {})
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).textFieldColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              FontAwesomeIcons.linkedinIn,
                              size: 20,
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 20.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RoundCheckBox(
                                  border: Border.all(width: 0),
                                  uncheckedWidget: Container(
                                    color: Color.fromRGBO(42, 42, 42, 1),
                                    child: Icon(
                                      Icons.check,
                                      size: 20,
                                    ),
                                  ),
                                  size: 30,
                                  onTap: (val) {})
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).textFieldColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              FontAwesomeIcons.twitter,
                              size: 20,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                "Share with socials",
                style: GoogleFonts.raleway(
                    fontSize: 15.0.sp,
                    color: Theme.of(context).textPrimaryColor),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Container(
                width: 30.0.w,
                height: 8.0.h,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).textFieldColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                            child: CountDropDown()))),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 4.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () async {
                        show(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 8.0.h,
                        width: 80.8.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(135, 207, 217, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Promote",
                          style: GoogleFonts.raleway(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textSecondaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingItem extends StatelessWidget {
  const RatingItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 4.0.w,
                  ),
                  Text("Cameron Williamson")
                ],
              ),
              Text(
                "Today 16:20",
                style: GoogleFonts.raleway(
                    color: Theme.of(context).feedTextSecondaryColor),
              )
            ],
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Theme.of(context).textFieldColor,
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBarIndicator(
                  rating: 2.75,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. I")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomImageContainer extends StatefulWidget {
  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  File? _image = null;

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null)
      setState(() {
        _image = File(image.path);
      });
  }

  final key1 = const ValueKey("key1");

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        print("object");
        _imgFromGallery();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 30.0.h,
          width: double.infinity,
          color: Theme.of(context).textFieldColor,
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.camera,
                        size: 8.0.h, color: Color.fromRGBO(180, 180, 181, 1)),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Add your cover event photo",
                      style: GoogleFonts.raleway(
                          fontSize: 12.0.sp,
                          color: Color.fromRGBO(87, 87, 89, 1),
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              : Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

class CountDropDown extends StatefulWidget {
  @override
  _CountDropDownState createState() => _CountDropDownState();
}

class _CountDropDownState extends State<CountDropDown> {
  String choosenValue = "\$ 5";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: choosenValue,
      alignment: Alignment.bottomCenter,
      //elevation: 5,
      style: GoogleFonts.raleway(
        color: Theme.of(context).textPrimaryColor,
      ),

      items: List.generate(5, (index) => ("\$ " + ((index + 1) * 5).toString()))
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: GoogleFonts.raleway(fontSize: 14.0.sp),
          ),
        );
      }).toList(),

      onChanged: (String? value) {
        setState(() {
          choosenValue = value!;
        });
      },
    );
  }
}
