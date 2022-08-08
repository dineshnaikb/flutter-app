import 'dart:io';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';

import 'package:sizer/sizer.dart';

class ModifyEventScreen extends StatefulWidget {
  static List<String> type = [
    'dating',
    'music',
    'dance',
    'new year',
    'friends',
    'corporate',
    'thematic',
    'crypto',
    'business',
  ];

  @override
  State<ModifyEventScreen> createState() => _ModifyEventScreenState();
}

class _ModifyEventScreenState extends State<ModifyEventScreen> {
  GroupController chipsController = GroupController(isMultipleSelection: true);
  EventState event = EventState();
  var selectedTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController vidURLController = TextEditingController();
  TextEditingController offeringController =
      TextEditingController(text: 'General Admission');

  _selectTime(BuildContext context, callback) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      callback(timeOfDay);
      setState(() {});
    }
  }

  var fromTime = TimeOfDay.now();
  var toTime = TimeOfDay.now();
  String fromAge = "18";
  String toAge = "18";

  setFromAge(String age) {
    fromAge = age;
  }

  setToAge(String age) {
    fromAge = age;
  }

  setFromTime(TimeOfDay time) {
    fromTime = time;
  }

  setToTime(TimeOfDay time) {
    toTime = time;
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'General Admission',
      'label': 'General Admission',
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
    },
  ];

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as EventState;
    // event = context.watch<EventState>();
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
      body: Builder(
        builder: (context) {
          titleController.text = event.title;
          placeController.text = event.place;
          vidURLController.text = event.video_url;
          offeringController.text = event.offering_option;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create an Event",
                      style: GoogleFonts.raleway(
                          fontSize: 20.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    height: 20.0.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return CustomImageContainer();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Event title",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  TextField(
                    controller: titleController,
                    onChanged: (value) {
                      context
                          .read<EventBloc>()
                          .add(EventAddtitle(title: value));
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'Create event title',
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Place",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  TextField(
                    controller: placeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'Add Event Place',
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Video URL link",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  TextField(
                    controller: vidURLController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'https://',
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Offering Option",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  SelectFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      suffixIcon: Icon(
                        Icons.arrow_downward,
                        color: Theme.of(context).appBarIconColor,
                      ),
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    initialValue: 'General Admission',
                    labelText: 'Shape',
                    items: _items,
                    onChanged: (val) => print(val),
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Event Type",
                          style: GoogleFonts.raleway(
                              fontSize: 15.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      ),
                      Container(
                        width: 20.0.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: Theme.of(context).textPrimaryColor),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Add",
                          style: GoogleFonts.raleway(
                              fontSize: 12.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  SimpleGroupedChips<String>(
                    controller: chipsController,
                    values: ModifyEventScreen.type,
                    itemTitle: ModifyEventScreen.type,
                    backgroundColorItem: Colors.black26,
                    isScrolling: false,
                    chipGroupStyle: ChipGroupStyle.minimize(
                      backgroundColorItem: Theme.of(context).textFieldColor,
                      textColor: Theme.of(context).textPrimaryColor,
                      selectedColorItem: Color.fromRGBO(134, 207, 217, 1),
                      selectedIcon: null,
                      itemTitleStyle: GoogleFonts.raleway(
                        fontSize: 12.0.sp,
                      ),
                    ),
                    onItemSelected: (values) {
                      print(values);
                    },
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Time",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _selectTime(context, setFromTime);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).textFieldColor,
                                  borderRadius: BorderRadius.circular(30)),
                              width: 30.0.w,
                              height: 6.0.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(fromTime.format(context)),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _selectTime(context, setToTime);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).textFieldColor,
                              borderRadius: BorderRadius.circular(30)),
                          width: 30.0.w,
                          height: 6.0.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(toTime.format(context)),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Food and Beverage",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
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
                      hintText:
                          'Please include what food and beverage will be offered',
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Age limit",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 35.0.w,
                        height: 8.0.h,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textFieldColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                  child: AgeDropDown(
                                hint: "From",
                                setAge: setFromAge,
                              ))),
                        ),
                      ),
                      Container(
                        width: 35.0.w,
                        height: 8.0.h,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textFieldColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                  child: AgeDropDown(
                                      hint: "To", setAge: setToAge))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Comments",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
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
                      hintText:
                          'Please specify any other detials such as dres code, etc',
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Desired Company",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "This is a paid event",
                          style: GoogleFonts.raleway(
                              fontSize: 15.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      ),
                      CustomSwitch(),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Text(
                    "I want to split the costs with a gustee",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(fontSize: 10.0.sp),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Male",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Female",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                        ),
                      ],
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
                            hintText: '\$500',
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
                            hintText: '\$1500',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Text(
                    "How many women and/ or men you wish to attend the event",
                    style: GoogleFonts.raleway(fontSize: 10.0.sp),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Male",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Female",
                            style: GoogleFonts.raleway(
                                fontSize: 15.0.sp,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 35.0.w,
                        height: 8.0.h,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textFieldColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                  child: CountDropDown(
                                choosenValue: 20,
                              ))),
                        ),
                      ),
                      Container(
                        width: 35.0.w,
                        height: 8.0.h,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textFieldColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                  child: CountDropDown(
                                choosenValue: 15,
                              ))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "COVID 19",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).textPrimaryColor),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text("Vaccine Proof",
                            style: GoogleFonts.raleway(
                                fontSize: 12.0.sp,
                                color: Theme.of(context).textPrimaryColor)),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).textPrimaryColor),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text("PCR Test Required",
                            style: GoogleFonts.raleway(
                                fontSize: 12.0.sp,
                                color: Theme.of(context).textPrimaryColor)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  SizedBox(
                    height: 2.0.h,
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
                            border: Border.all(
                                color: Theme.of(context).textPrimaryColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Add/invite Friends",
                            style: GoogleFonts.raleway(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                        ),
                      ),
                    ],
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
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 8.0.h,
                          width: 80.8.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).textPrimaryColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Co-share an Event",
                            style: GoogleFonts.raleway(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).textPrimaryColor),
                          ),
                        ),
                      ),
                    ],
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
                            "Done",
                            style: GoogleFonts.raleway(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 14.0.w,
      height: 4.0.h,
      valueFontSize: 25.0,
      toggleSize: 6.0.w,
      activeColor: Color.fromRGBO(38, 174, 101, 1),
      value: status,
      borderRadius: 30.0,
      showOnOff: false,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
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

    setState(() {
      _image = File(image!.path);
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 35.0.h,
            width: 35.0.w,
            color: Theme.of(context).textFieldColor,
            child: _image == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          size: 8.0.h, color: Color.fromRGBO(180, 180, 181, 1)),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      Text(
                        "Add your event photo",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                            fontSize: 11.0.sp,
                            color: Theme.of(context).feedTextSecondaryColor,
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
      ),
    );
  }
}

class AgeDropDown extends StatefulWidget {
  final hint;
  Function setAge;
  AgeDropDown({this.hint, required this.setAge});
  @override
  _AgeDropDownState createState() => _AgeDropDownState();
}

class _AgeDropDownState extends State<AgeDropDown> {
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: _chosenValue,
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
      hint: widget.hint != null
          ? Text(
              widget.hint,
              style: GoogleFonts.raleway(
                  color: Theme.of(context).textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          : null,
      onChanged: (String? value) {
        widget.setAge(value);
        setState(() {
          _chosenValue = value!;
        });
      },
    );
  }
}

class CountDropDown extends StatefulWidget {
  final choosenValue;
  CountDropDown({this.choosenValue});
  @override
  _CountDropDownState createState() => _CountDropDownState();
}

class _CountDropDownState extends State<CountDropDown> {
  String choosenValue = "20";
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

      items: List.generate(20, (index) => (index + 18).toString())
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
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
