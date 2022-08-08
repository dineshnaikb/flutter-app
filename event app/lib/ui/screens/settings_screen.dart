import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/image_status.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController interestEditingController = TextEditingController();
  TextEditingController sportsEditingController = TextEditingController();
  TextEditingController foodEditingController = TextEditingController();
  TextEditingController movieEditingController = TextEditingController();
  TextEditingController personalityTypeEditingController =
      TextEditingController();
  TextEditingController travelEditingController = TextEditingController();
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController linkedin = TextEditingController();

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Female',
      'label': 'Female',
    },
    {
      'value': 'Male',
      'label': 'Male',
    },
  ];

  final List<Map<String, dynamic>> _itemsInterests = [
    {
      'value': 'Dancing',
      'label': 'Dancing',
    },
    {
      'value': 'Singing',
      'label': 'Singing',
    },
  ];

  final List<Map<String, dynamic>> _itemsSports = [
    {
      'value': 'Weight Training',
      'label': 'Weight Training',
    },
    {
      'value': 'Yoga',
      'label': 'Yoga',
    },
  ];

  final List<Map<String, dynamic>> _itemsFoods = [
    {
      'value': 'Vegan',
      'label': 'Vegan',
    },
    {
      'value': 'Pizza',
      'label': 'Pizza',
    },
  ];
  final List<Map<String, dynamic>> _itemsMovies = [
    {
      'value': 'Comedy',
      'label': 'Comedy',
    },
    {
      'value': 'Horror',
      'label': 'Horror',
    },
  ];

  final List<Map<String, dynamic>> _itemsPersonalityTypes = [
    {
      'value': 'Creator',
      'label': 'Creator',
    },
    {
      'value': 'Caregiver',
      'label': 'Caregiver',
    },
  ];

  final List<Map<String, dynamic>> _itemsTravel = [
    {
      'value': '1 time/year',
      'label': '1 time/year',
    },
    {
      'value': '2 times/year',
      'label': '2 times/year',
    },
    {
      'value': '3 times/year',
      'label': '3 times/year',
    },
    {
      'value': '4 times/year',
      'label': '4 times/year',
    },
    {
      'value': '5 times/year',
      'label': '5 times/year',
    },
  ];
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    interestEditingController.text = "Dancing";
    sportsEditingController.text = "Weight Training";
    foodEditingController.text = "Pizza";
    movieEditingController.text = "Comedy";
    personalityTypeEditingController.text = 'Creator';
    travelEditingController.text = '5 times/year';
    context.read<SettingsBloc>().add(SettingsInitial());
    setState(() {});
    super.initState();
  }

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).profileBottomSheetColor,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: Container(
            height: 50.0.h,
            margin: EdgeInsets.symmetric(horizontal: 8.0.w),
            color: Theme.of(context).profileBottomSheetColor,
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment method",
                            style: GoogleFonts.raleway(fontSize: 14.0.sp),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Theme.of(context).appBarIconColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 25.0.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Card",
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    RoundCheckBox(
                                        border: Border.all(width: 0),
                                        uncheckedWidget: Container(
                                          color: Color.fromRGBO(42, 42, 42, 1),
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                          ),
                                        ),
                                        size: 30,
                                        onTap: (val) {})
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Image.asset(
                                'assets/card.png',
                                width: 22.0.w,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 25.0.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Card",
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    RoundCheckBox(
                                        border: Border.all(width: 0),
                                        uncheckedWidget: Container(
                                          color: Color.fromRGBO(42, 42, 42, 1),
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                          ),
                                        ),
                                        size: 30,
                                        onTap: (val) {})
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Image.asset(
                                'assets/card.png',
                                width: 22.0.w,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 25.0.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Card",
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    RoundCheckBox(
                                        border: Border.all(width: 0),
                                        uncheckedWidget: Container(
                                          color: Color.fromRGBO(42, 42, 42, 1),
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                          ),
                                        ),
                                        size: 30,
                                        onTap: (val) {})
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Image.asset(
                                'assets/card.png',
                                width: 22.0.w,
                              )
                            ],
                          ),
                        ],
                      ),
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
                            height: 5.0.h,
                            width: 60.8.w,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(135, 207, 217, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Choose",
                              style: GoogleFonts.raleway(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).textSecondaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  Widget buildPopUp(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Container(
          height: 40.0.h,
          child: Column(
            children: [
              Container(
                height: 15.0.h,
                child: Image.asset(
                  'assets/congratulations.png',
                  width: 20.0.w,
                ),
              ),
              // SizedBox(
              //   height: 2.0.h,
              // ),
              // Container(
              //   height: 4.0.h,
              //   child: Text(
              //     "Congratulations!",
              //     style: GoogleFonts.raleway(fontSize: 20.0.sp),
              //   ),
              // ),
              SizedBox(
                height: 2.0.h,
              ),
              Container(
                height: 7.0.h,
                child: Text(
                  "Your settings have been updated",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      color: Theme.of(context).feedTextSecondaryColor),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              // InkWell(
              //   onTap: () {
              //     Share.share('Check out my event :  https://example.com');
              //   },
              //   child: Container(
              //     height: 6.0.h,
              //     child: Text(
              //       "Share with socials",
              //       style: GoogleFonts.raleway(fontSize: 15.0.sp),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 2.0.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     RoundCheckBox(
              //       border: Border.all(width: 0),
              //       size: 8.0.w,
              //       onTap: (selected) {},
              //     ),
              //     RoundCheckBox(
              //       border: Border.all(width: 0),
              //       size: 8.0.w,
              //       onTap: (selected) {},
              //     ),
              //     RoundCheckBox(
              //       border: Border.all(width: 0),
              //       size: 8.0.w,
              //       onTap: (selected) {},
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 2.0.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //           color: Theme.of(context).popUpIconBackgroundColor,
              //           borderRadius: BorderRadius.circular(50)),
              //       child: Icon(
              //         FontAwesomeIcons.facebookF,
              //         size: 5.0.w,
              //         color: Color.fromRGBO(106, 157, 252, 1),
              //       ),
              //     ),
              //     Container(
              //       padding: EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //           color: Theme.of(context).popUpIconBackgroundColor,
              //           borderRadius: BorderRadius.circular(50)),
              //       child: Icon(
              //         FontAwesomeIcons.instagram,
              //         color: Color.fromRGBO(106, 157, 252, 1),
              //         size: 5.0.w,
              //       ),
              //     ),
              //     Container(
              //       padding: EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //           color: Theme.of(context).popUpIconBackgroundColor,
              //           borderRadius: BorderRadius.circular(50)),
              //       child: Icon(
              //         FontAwesomeIcons.linkedinIn,
              //         color: Color.fromRGBO(114, 184, 244, 1),
              //         size: 5.0.w,
              //       ),
              //     ),
              //   ],
              // ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 6.5.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(135, 207, 217, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Done",
                    style: GoogleFonts.raleway(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
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
        body: SingleChildScrollView(
          child: Builder(builder: (context) {
            Map userData = {};

            userData = context.watch<SettingsBloc>().state.toMap();

            firstName.text = userData['first_name'].toString();
            lastName.text = userData['last_name'].toString();
            email.text = userData['email'].toString();
            bio.text = userData['bio'].toString();
            facebook.text = userData['fb'].toString();
            instagram.text = userData['insta'].toString();
            linkedin.text = userData['linken'].toString();
            // travelEditingController.text = userData['travel'].toString();
            return Form(
              key: formkey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(
                      "Settings",
                      style: GoogleFonts.raleway(
                          fontSize: 20.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Text(
                      "Profile Info",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    DisplayPicture(),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextField(
                      controller: firstName,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Theme.of(context).textFieldColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        hintText: 'First Name',
                      ),
                      onEditingComplete: () {
                        context
                            .read<SettingsBloc>()
                            .add(SettingsFirstNameChange(name: firstName.text));
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      onSubmitted: (value) {
                        context
                            .read<SettingsBloc>()
                            .add(SettingsFirstNameChange(name: firstName.text));
                      },
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextField(
                        controller: lastName,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Theme.of(context).textFieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Last Name',
                        ),
                        onSubmitted: (value) {
                          context
                              .read<SettingsBloc>()
                              .add(SettingsLastNameChange(name: value));
                        }),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    if (context.watch<SettingsBloc>().state.accountProvider ==
                        '')
                      TextFormField(
                          validator: (value) {
                            if (!EmailValidator.validate(value!)) {
                              return "Enter a valid email";
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            filled: true,
                            fillColor: Theme.of(context).textFieldColor,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                            hintText: 'Email',
                          ),
                          onFieldSubmitted: (value) {
                            if (formkey.currentState!.validate()) {
                              context
                                  .read<SettingsBloc>()
                                  .add(SettingsEmailChange(email: value));
                            }
                          }),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 30.0.w,
                          height: 9.5.h,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Theme.of(context).textFieldColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(left: 4.0.w, top: 1.0.h),
                                child: Text(
                                  "Age",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.raleway(fontSize: 8.0.sp),
                                ),
                              ),
                              Center(
                                child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                        child: CountDropDown())),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 40.0.w,
                            height: 9.5.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).textFieldColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 3.0.w, top: 1.5.h),
                                  child: Text(
                                    "Sex",
                                    style: GoogleFonts.raleway(fontSize: 7.sp),
                                  ),
                                ),
                                SelectFormField(
                                    style:
                                        GoogleFonts.raleway(fontSize: 10.0.sp),
                                    decoration: InputDecoration(
                                      filled: true,
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                        color:
                                            Theme.of(context).appBarIconColor,
                                      ),
                                      fillColor:
                                          Theme.of(context).textFieldColor,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    type: SelectFormFieldType
                                        .dropdown, // or can be dialog
                                    initialValue: context
                                        .watch<SettingsBloc>()
                                        .state
                                        .gender,
                                    items: _items,
                                    onChanged: (val) {
                                      context.read<SettingsBloc>().add(
                                          SettingsGenderChange(gender: val));
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextField(
                        controller: bio,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        maxLength: 150,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Theme.of(context).textFieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Bio',
                        ),
                        onSubmitted: (value) {
                          print(value);
                        },
                        onEditingComplete: () {
                          print("www");
                        },
                        onChanged: (val) {
                          print("www");
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<SettingsBloc>()
                                .add(SettingsBioChange(bio: bio.text));
                          },
                          child: Container(
                            height: 6.0.h,
                            width: 25.0.w,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(135, 207, 217, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "Update Bio",
                              style: GoogleFonts.raleway(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Social Media",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    TextField(
                        controller: facebook,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Theme.of(context).textFieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Facebook',
                        ),
                        onSubmitted: (value) {
                          context
                              .read<SettingsBloc>()
                              .add(SettingsFacebookChange(facebook: value));
                        }),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    TextField(
                        controller: instagram,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Theme.of(context).textFieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Instagram',
                        ),
                        onSubmitted: (value) {
                          context
                              .read<SettingsBloc>()
                              .add(SettingsInstagramChange(instagtam: value));
                        }),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    // TextField(
                    //     decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.all(20),
                    //       filled: true,
                    //       fillColor: Theme.of(context).textFieldColor,
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,
                    //           borderRadius: BorderRadius.circular(25)),
                    //       hintText: 'Twitter',
                    //     ),
                    //     onSubmitted: (value) {
                    //       context
                    //           .read<SettingsBloc>()
                    //           .add(SettingsTwitterChange(twitter: value));
                    //     }),
                    // SizedBox(
                    //   height: 2.0.h,
                    // ),
                    // TextField(
                    //     decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.all(20),
                    //       filled: true,
                    //       fillColor: Theme.of(context).textFieldColor,
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,
                    //           borderRadius: BorderRadius.circular(25)),
                    //       hintText: 'TikTok',
                    //     ),
                    //     onSubmitted: (value) {
                    //       context
                    //           .read<SettingsBloc>()
                    //           .add(SettingsTikTokChange(tiktok: value));
                    //     }),
                    // SizedBox(
                    //   height: 2.0.h,
                    // ),
                    TextField(
                        controller: linkedin,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Theme.of(context).textFieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Linkedin',
                        ),
                        onSubmitted: (value) {
                          context
                              .read<SettingsBloc>()
                              .add(SettingsLinkedinChange(linkedin: value));
                        }),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Payment method",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    InkWell(
                      onTap: () {
                        show(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0.h, horizontal: 5.0.w),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textFieldColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PayPal",
                              style: GoogleFonts.raleway(
                                  fontSize: 12.0.sp,
                                  color:
                                      Theme.of(context).feedTextSecondaryColor),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).feedTextSecondaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Interests",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Theme.of(context).textFieldColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60.0.w,
                              margin: EdgeInsets.only(left: 2.0.w),
                              child: SelectFormField(
                                controller: interestEditingController,
                                enableSearch: true,
                                style: GoogleFonts.raleway(fontSize: 10.0.sp),
                                decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context).appBarIconColor,
                                  ),
                                  fillColor: Theme.of(context).textFieldColor,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),

                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                // initialValue: 'Weight Training',

                                items: _itemsInterests,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (interestEditingController.text
                                    .toString()
                                    .isNotEmpty) {
                                  context.read<SettingsBloc>().add(
                                      SettingsInterestsChange(
                                          interest:
                                              interestEditingController.text));
                                }
                              },
                              child: Container(
                                height: 5.0.h,
                                width: 20.0.w,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(135, 207, 217, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "add",
                                  style:
                                      GoogleFonts.raleway(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Builder(builder: (context) {
                      List<Widget> interests = context
                          .watch<SettingsBloc>()
                          .state
                          .interests
                          .map((s) => Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      s,
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<SettingsBloc>().add(
                                            SettingsInterestDelete(
                                                interest: s));
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color:
                                            Theme.of(context).appBarIconColor,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList();
                      return Wrap(
                          spacing: 20, runSpacing: 20, children: interests);
                    }),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Sport",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Theme.of(context).textFieldColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60.0.w,
                              margin: EdgeInsets.only(left: 2.0.w),
                              child: SelectFormField(
                                controller: sportsEditingController,
                                enableSearch: true,
                                style: GoogleFonts.raleway(fontSize: 10.0.sp),
                                decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context).appBarIconColor,
                                  ),
                                  fillColor: Theme.of(context).textFieldColor,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),

                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                // initialValue: 'Weight Training',

                                items: _itemsSports,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (sportsEditingController.text
                                    .toString()
                                    .isNotEmpty) {
                                  context.read<SettingsBloc>().add(
                                      SettingsAddSports(
                                          sport: sportsEditingController.text));
                                }
                              },
                              child: Container(
                                height: 5.0.h,
                                width: 20.0.w,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(135, 207, 217, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "add",
                                  style:
                                      GoogleFonts.raleway(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Builder(builder: (context) {
                      List<Widget> foods = context
                          .watch<SettingsBloc>()
                          .state
                          .sports
                          .map((s) => Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      s,
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<SettingsBloc>().add(
                                            SettingsDeleteSports(sport: s));
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color:
                                            Theme.of(context).appBarIconColor,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList();
                      return Wrap(spacing: 20, runSpacing: 20, children: foods);
                    }),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Food Preferences",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Theme.of(context).textFieldColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60.0.w,
                              margin: EdgeInsets.only(left: 2.0.w),
                              child: SelectFormField(
                                controller: foodEditingController,
                                enableSearch: true,
                                style: GoogleFonts.raleway(fontSize: 10.0.sp),
                                decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context).appBarIconColor,
                                  ),
                                  fillColor: Theme.of(context).textFieldColor,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),

                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                // initialValue: 'Weight Training',

                                items: _itemsFoods,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (foodEditingController.text
                                    .toString()
                                    .isNotEmpty) {
                                  context.read<SettingsBloc>().add(
                                      SettingsAddFood(
                                          food: foodEditingController.text));
                                }
                              },
                              child: Container(
                                height: 5.0.h,
                                width: 20.0.w,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(135, 207, 217, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "add",
                                  style:
                                      GoogleFonts.raleway(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Builder(builder: (context) {
                      List<Widget> foods = context
                          .watch<SettingsBloc>()
                          .state
                          .food
                          .map((s) => Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      s,
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<SettingsBloc>()
                                            .add(SettingsDeleteFood(food: s));
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color:
                                            Theme.of(context).appBarIconColor,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList();
                      return Wrap(spacing: 20, runSpacing: 20, children: foods);
                    }),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Movie Preferences",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Theme.of(context).textFieldColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60.0.w,
                              margin: EdgeInsets.only(left: 2.0.w),
                              child: SelectFormField(
                                controller: movieEditingController,
                                enableSearch: true,
                                style: GoogleFonts.raleway(fontSize: 10.0.sp),
                                decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context).appBarIconColor,
                                  ),
                                  fillColor: Theme.of(context).textFieldColor,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),

                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                // initialValue: 'Weight Training',

                                items: _itemsMovies,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (movieEditingController.text
                                    .toString()
                                    .isNotEmpty) {
                                  // context.read<SettingsBloc>().add(
                                  //     SettingsAddMovie(
                                  //         movie: movieEditingController.text));
                                }
                              },
                              child: Container(
                                height: 5.0.h,
                                width: 20.0.w,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(135, 207, 217, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "add",
                                  style:
                                      GoogleFonts.raleway(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Builder(builder: (context) {
                      List<Widget> movies = context
                          .watch<SettingsBloc>()
                          .state
                          .movies
                          .map((s) => Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      s,
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // context
                                        //     .read<SettingsBloc>()
                                        //     .add(SettingsDeleteMovie(movie: s));
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color:
                                            Theme.of(context).appBarIconColor,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList();
                      return Wrap(
                          spacing: 20, runSpacing: 20, children: movies);
                    }),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Personality Types",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Theme.of(context).textFieldColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60.0.w,
                              margin: EdgeInsets.only(left: 2.0.w),
                              child: SelectFormField(
                                controller: personalityTypeEditingController,
                                enableSearch: true,
                                style: GoogleFonts.raleway(fontSize: 10.0.sp),
                                decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context).appBarIconColor,
                                  ),
                                  fillColor: Theme.of(context).textFieldColor,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),

                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                // initialValue: 'Weight Training',

                                items: _itemsPersonalityTypes,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (personalityTypeEditingController
                                    .toString()
                                    .isNotEmpty) {
                                  context.read<SettingsBloc>().add(
                                      SettingsAddPersonality(
                                          type: personalityTypeEditingController
                                              .text));
                                }
                              },
                              child: Container(
                                height: 5.0.h,
                                width: 20.0.w,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(135, 207, 217, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "add",
                                  style:
                                      GoogleFonts.raleway(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Builder(builder: (context) {
                      List<Widget> movies = context
                          .watch<SettingsBloc>()
                          .state
                          .personallity
                          .map((s) => Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      s,
                                      style: GoogleFonts.raleway(
                                          fontSize: 12.0.sp),
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<SettingsBloc>().add(
                                            SettingsDeletePersonality(type: s));
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color:
                                            Theme.of(context).appBarIconColor,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList();
                      return Wrap(
                          spacing: 20, runSpacing: 20, children: movies);
                    }),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      "Travel",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      child: SelectFormField(
                        // controller: travelEditingController,
                        style: GoogleFonts.raleway(fontSize: 10.0.sp),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).appBarIconColor,
                          ),
                          fillColor: Theme.of(context).textFieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                        ),

                        type: SelectFormFieldType.dropdown, // or can be dialog
                        initialValue:
                            context.watch<SettingsBloc>().state.travel,

                        items: _itemsTravel,
                        onChanged: (val) => {
                          context
                              .read<SettingsBloc>()
                              .add(SettingsTravelChange(times: val))
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notifications",
                          style: GoogleFonts.raleway(
                              fontSize: 15.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                        FlutterSwitch(
                          width: 14.0.w,
                          height: 4.0.h,
                          valueFontSize: 25.0,
                          toggleSize: 6.0.w,
                          activeColor: Color.fromRGBO(38, 174, 101, 1),
                          value:
                              context.watch<SettingsBloc>().state.notifications,
                          borderRadius: 30.0,
                          showOnOff: false,
                          onToggle: (val) {
                            context
                                .read<SettingsBloc>()
                                .add(SettingsToggleNotifications(enabled: val));
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    RoundedLoadingButton(
                      animateOnTap: false,
                      color: const Color.fromRGBO(134, 207, 217, 1),
                      child: Container(
                        alignment: Alignment.center,
                        height: 8.0.h,
                        width: 80.8.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(134, 207, 217, 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Update Settings",
                          style: GoogleFonts.raleway(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      controller: _btnController,
                      onPressed: () async {
                        _btnController.start();
                        context.read<SettingsBloc>().add(SettingsUpdateBio());
                        _btnController.success();
                        context.read<SettingsBloc>().add(SettingsInitial());
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                buildPopUp(context));
                        _btnController.reset();
                        // if (formkey.currentState!.validate()) {
                        //   scrollController.animateTo(0,
                        //       duration: Duration(milliseconds: 200),
                        //       curve: Curves.linear);
                        // } else {
                        //   _btnController.start();
                        //   context.read<EventBloc>().add(EventSubmitted());
                        // }
                      },
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     height: 6.0.h,
                    //     width: MediaQuery.of(context).size.width * 0.9,
                    //     alignment: Alignment.center,
                    //     margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                    //     decoration: BoxDecoration(
                    //       color: const Color.fromRGBO(135, 207, 217, 1),
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: Text(
                    //       "Update Settings",
                    //       style: GoogleFonts.raleway(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () =>
                          Navigator.pushNamed(context, '/about_screen'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "About",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy_screen');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Privacy",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/security_screen');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Security",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () =>
                          Navigator.pushNamed(context, '/transaction_history'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transaction History",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delete account",
                          style: GoogleFonts.raleway(
                              fontSize: 15.0.sp, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    InkWell(
                      onTap: () async {
                        final SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        _prefs.remove('user_id');
                        _prefs.remove('user_obj');
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, '/');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign Out",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class DisplayPicture extends StatefulWidget {
  const DisplayPicture({
    Key? key,
  }) : super(key: key);

  @override
  State<DisplayPicture> createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {
  File? _image = null;

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop the image',
            toolbarColor: Theme.of(context).backgroundColor,
            toolbarWidgetColor: Theme.of(context).textPrimaryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    _image = File(croppedFile!.path);

    context.read<SettingsBloc>().add(SettingsAddImage(image: _image!.path));
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    _image = File(image!.path);

    context.read<SettingsBloc>().add(SettingsAddImage(image: _image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _imgFromCamera();
      },
      child: Container(
        child: Stack(
          children: [
            if (context.watch<SettingsBloc>().state.imageSubmissionStatus
                is ImageSubmitting)
              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 16.0.w,
                  child: Center(child: CircularProgressIndicator())),
            if (context.watch<SettingsBloc>().state.imageUrl != '')
              FutureBuilder<bool?>(
                builder: (ctx, snapshot) {
                  print(snapshot.data!);
                  // Displaying LoadingSpinner to indicate waiting state
                  return CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 16.0.w,
                      backgroundImage: snapshot.data!
                          ? NetworkImage(
                              '${context.watch<SettingsBloc>().state.imageUrl}')
                          : const NetworkImage(
                              'https://nextopay.com/uploop/images/users/user.png'));
                },
                future:
                    File(context.watch<SettingsBloc>().state.imageUrl).exists(),
              ),
            if (context.watch<SettingsBloc>().state.imageUrl == '')
              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 16.0.w,
                  backgroundImage:
                      AssetImage(Theme.of(context).displayProfilePicture)),
            Positioned(
              bottom: 0.0.h,
              right: 3.0.w,
              child: Container(
                width: 8.0.w,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(117, 119, 123, 1),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CountDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: context.watch<SettingsBloc>().state.age == ""
          ? "20"
          : context.watch<SettingsBloc>().state.age,
      alignment: Alignment.bottomCenter,
      //elevation: 5,
      style: GoogleFonts.raleway(
        color: Theme.of(context).textPrimaryColor,
      ),

      items: List.generate(20, (index) => (index + 18).toString())
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

      onChanged: (String? value) {
        context.read<SettingsBloc>().add(SettingsAgeChange(age: value!));
      },
    );
  }
}
