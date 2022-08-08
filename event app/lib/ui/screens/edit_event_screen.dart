import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/bloc/form_submission.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditEventScreen extends StatefulWidget {
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
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'General Admission',
      'label': 'General Admission',
    },
    {
      'value': 'VIP',
      'label': 'VIP',
    },
    {
      'value': 'Other',
      'label': 'Other',
    },
  ];
  // TextEditingController titleController = TextEditingController();
  // TextEditingController placeController = TextEditingController();
  // TextEditingController vidURLController = TextEditingController();
  // TextEditingController offeringController = TextEditingController();
  // TextEditingController foodAndBeveragesController = TextEditingController();
  // TextEditingController commentsController = TextEditingController();
  // TextEditingController malePriceController = TextEditingController();
  // TextEditingController femalePriceController = TextEditingController();
  getTags() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    Response response = await Dio().get(
        'https://nextopay.com/uploop/event_type_tags?userid=${_prefs.getString("user_id")}&token=${json.decode(_prefs.getString("user_obj")!)['tocken']}');
    print(response.data);
    List tags = json.decode(response.data)['data'];
    EditEventScreen.type = [];
    tags.forEach((element) {
      EditEventScreen.type.add(element['tags_name']);
    });
    setState(() {});
  }

  @override
  void initState() {
    EventState event = ModalRoute.of(context)!.settings.arguments as EventState;
    context.read<EventBloc>().add(EventEditInitial(eventToEdit: event));

    super.initState();
  }

  GroupController chipsController = GroupController(isMultipleSelection: true);
  final formkey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 100.0.w,
        child: GooglePlaceAutoCompleteTextField(
            textEditingController: controller,
            googleAPIKey: "AIzaSyBLUNpEMEXbSZWhbVdUopU9wVNLLo0FGTY",
            inputDecoration: InputDecoration(
              focusedBorder: InputBorder.none,
              hintText: "Search your location",
              fillColor: Theme.of(context).textFieldColor,
              filled: true,
            ),
            debounceTime: 800,
            countries: ["in", "fr"],
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              print("placeDetails" + prediction.lng.toString());
            },
            itmClick: (Prediction prediction) {
              print("wwww");
              controller.text = prediction.description!;

              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description!.length));
            }
            // default 600 ms ,
            ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          var current = state.formSubmissionStatus;
          if (current is SubmissionSuccess) {
            _btnController.success();
            showDialog(
                context: context,
                builder: (BuildContext context) => buildPopUp(context));
            context.read<EventBloc>().add(EventComplete());
          } else if (current is SubmissionFailed) {
            _btnController.error();
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            controller: scrollController,
            child: Form(
              key: formkey,
              child: Column(
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
                    height: 30.0.h,
                    child: MainImageContainer(),
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Container(
                    height: 20.0.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return CustomImageContainer(
                          index: index,
                        );
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
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Event title cannot be empty";
                      }
                    },
                    onChanged: (value) {
                      context
                          .read<EventBloc>()
                          .add(EventAddtitle(title: value));
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      hintStyle: GoogleFonts.raleway(
                          color: Theme.of(context).feedTextSecondaryColor),
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
                  // placesAutoCompleteTextField(),
                  SizedBox(
                    height: 2.0.h,
                  ),

                  SizedBox(
                    height: 2.0.h,
                  ),
                  //--------------------------------

                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Event place cannot be empty";
                      }
                    },
                    onChanged: (value) {
                      context
                          .read<EventBloc>()
                          .add(EventAddPlace(place: value));
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      hintStyle: GoogleFonts.raleway(
                          color: Theme.of(context).feedTextSecondaryColor),
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'Add event place',
                    ),
                  ),

                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(25),
                  //   child: SearchGooglePlacesWidget(
                  //     iconColor: Theme.of(context).appBarIconColor,
                  //     placeType: PlaceType
                  //         .address, // PlaceType.cities, PlaceType.geocode, PlaceType.region etc
                  //     placeholder: '',
                  //     apiKey: 'AIzaSyBLUNpEMEXbSZWhbVdUopU9wVNLLo0FGTY',
                  //     onSearch: (Place place) {
                  //       print("object");
                  //       print(place);
                  //     },
                  //     darkMode: Theme.of(context).dark_mode,
                  //     onSelected: (Place place) async {
                  //       print('address ${place.description}');
                  //     },
                  //   ),
                  // ),

                  //--------------------------------

                  SizedBox(
                    height: 2.0.h,
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
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Video URL cannot be empty";
                      }
                    },
                    onChanged: (value) {
                      context.read<EventBloc>().add(EventAddVideo(link: value));
                    },
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
                    onChanged: (value) {
                      context
                          .read<EventBloc>()
                          .add(EventAddOfferingOption(option: value));
                    },
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
                    values: EditEventScreen.type,
                    itemTitle: EditEventScreen.type,
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
                      context
                          .read<EventBloc>()
                          .add(EventAddType(types: values));
                    },
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Event Date",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter event date';
                      }
                    },
                    onChanged: (value) {
                      context
                          .read<EventBloc>()
                          .add(EventAddEventDate(date: value));
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      hintMaxLines: 2,
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'Please specify event date',
                    ),
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
                            onTap: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                              if (timeOfDay != null) {
                                context.read<EventBloc>().add(EventAddFromTime(
                                    time: timeOfDay.format(context)));
                              }
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
                                  Text(context
                                      .watch<EventBloc>()
                                      .state
                                      .from_time),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.dial,
                          );
                          if (timeOfDay != null) {
                            context.read<EventBloc>().add(EventAddToTime(
                                time: timeOfDay.format(context)));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).textFieldColor,
                              borderRadius: BorderRadius.circular(30)),
                          width: 30.0.w,
                          height: 6.0.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(context.watch<EventBloc>().state.to_time),
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
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please include what food and beverage will be offered';
                      }
                    },
                    onChanged: (value) {
                      context
                          .read<EventBloc>()
                          .add(EventAddFoodAndBeverage(text: value));
                    },
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
                                  child: DropdownButton<String>(
                                isExpanded: true,
                                value: context
                                            .watch<EventBloc>()
                                            .state
                                            .from_age ==
                                        ""
                                    ? null
                                    : context.watch<EventBloc>().state.from_age,
                                alignment: Alignment.bottomCenter,
                                //elevation: 5,
                                style: GoogleFonts.raleway(
                                  color: Theme.of(context).textPrimaryColor,
                                ),

                                items: List.generate(
                                        20, (index) => (index + 18).toString())
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "From",
                                  style: GoogleFonts.raleway(
                                      color: Theme.of(context).textPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),

                                onChanged: (String? value) {
                                  context
                                      .read<EventBloc>()
                                      .add(EventAddFromAge(age: value!));
                                },
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
                                  child: DropdownButton<String>(
                                isExpanded: true,
                                value: context
                                            .watch<EventBloc>()
                                            .state
                                            .to_age ==
                                        ""
                                    ? null
                                    : context.watch<EventBloc>().state.to_age,
                                alignment: Alignment.bottomCenter,
                                //elevation: 5,
                                style: GoogleFonts.raleway(
                                  color: Theme.of(context).textPrimaryColor,
                                ),
                                items: List.generate(
                                        20, (index) => (index + 18).toString())
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "To",
                                  style: GoogleFonts.raleway(
                                      color: Theme.of(context).textPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                onChanged: (String? value) {
                                  context
                                      .read<EventBloc>()
                                      .add(EventAddToAge(age: value!));
                                },
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
                      "Comments",
                      style: GoogleFonts.raleway(
                          fontSize: 15.0.sp,
                          color: Theme.of(context).textPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please specify any other detials such as dress code, etc';
                      }
                    },
                    onChanged: (value) {
                      context
                          .read<EventBloc>()
                          .add(EventAddComments(comment: value));
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      hintMaxLines: 2,
                      fillColor: Theme.of(context).textFieldColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      hintText:
                          'Please specify any other detials such as dress code, etc',
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
                      FlutterSwitch(
                        width: 14.0.w,
                        height: 4.0.h,
                        valueFontSize: 25.0,
                        toggleSize: 6.0.w,
                        activeColor: Color.fromRGBO(38, 174, 101, 1),
                        value: context.watch<EventBloc>().state.paid_event,
                        borderRadius: 30.0,
                        showOnOff: false,
                        onToggle: (val) {
                          context
                              .read<EventBloc>()
                              .add(EventTogglePaidEvent(enabled: val));
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),

                  Text(
                    "I want to split the costs with guests",
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
                        child: TextFormField(
                          onChanged: (val) {
                            context
                                .read<EventBloc>()
                                .add(EventAddMalePrice(price: val));
                          },
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
                        child: TextFormField(
                          onChanged: (val) {
                            context
                                .read<EventBloc>()
                                .add(EventAddFemalePrice(price: val));
                          },
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
                  // SizedBox(
                  //   height: 2.0.h,
                  // ),
                  //
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
                                  child: DropdownButton<String>(
                                isExpanded: true,
                                value:
                                    context.watch<EventBloc>().state.female_no,
                                alignment: Alignment.bottomCenter,
                                //elevation: 5,
                                style: GoogleFonts.raleway(
                                  color: Theme.of(context).textPrimaryColor,
                                ),

                                items: List.generate(
                                        20, (index) => (index + 18).toString())
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),

                                onChanged: (String? value) {
                                  context
                                      .read<EventBloc>()
                                      .add(EventAddMaleNo(no: value!));
                                },
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
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                isExpanded: true,
                                value:
                                    context.watch<EventBloc>().state.female_no,
                                alignment: Alignment.bottomCenter,
                                //elevation: 5,
                                style: GoogleFonts.raleway(
                                  color: Theme.of(context).textPrimaryColor,
                                ),

                                items: List.generate(
                                        20, (index) => (index + 18).toString())
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),

                                onChanged: (String? value) {
                                  context
                                      .read<EventBloc>()
                                      .add(EventAddFemaleNo(no: value!));
                                },
                              ))),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "This is a virtual event",
                          style: GoogleFonts.raleway(
                              fontSize: 15.0.sp,
                              color: Theme.of(context).textPrimaryColor),
                        ),
                      ),
                      FlutterSwitch(
                        width: 14.0.w,
                        height: 4.0.h,
                        valueFontSize: 25.0,
                        toggleSize: 6.0.w,
                        activeColor: Color.fromRGBO(38, 174, 101, 1),
                        value: context.watch<EventBloc>().state.virtual_event,
                        borderRadius: 30.0,
                        showOnOff: false,
                        onToggle: (val) {
                          context
                              .read<EventBloc>()
                              .add(EventToggleVirtualEvent(enabled: val));
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0.h,
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
                        onTap: () =>
                            Navigator.pushNamed(context, '/invited_friends'),
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
                  SizedBox(
                    height: 2.0.h,
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
                    controller: _btnController,
                    onPressed: () {
                      _btnController.start();
                      context.read<EventBloc>().add(EventSubmitted());
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
                  SizedBox(
                    height: 15.0.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// if (context.watch<SettingsBloc>().state.firstname == '')
//   BackdropFilter(
//     filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
//     child: Align(
//         alignment: Alignment.center,
//         child: AlertDialog(
//           backgroundColor: Theme.of(context).secondaryBackgroundColor,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30)),
//           content: Container(
//               height: 30.0.h,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Please update your profile to proceed ... "),
//                   SizedBox(
//                     height: 5.0.h,
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(50),
//                     onTap: () async {
//                       Navigator.pushNamed(
//                           context, '/settings_screen');
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: 8.0.h,
//                       width: 60.8.w,
//                       decoration: BoxDecoration(
//                         color: const Color.fromRGBO(135, 207, 217, 1),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Text(
//                         "Update Profile",
//                         style: GoogleFonts.raleway(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w500,
//                             color:
//                                 Theme.of(context).textSecondaryColor),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         )),
//   ),
class MainImageContainer extends StatefulWidget {
  MainImageContainer();
  @override
  State<MainImageContainer> createState() => _MainImageContainerState();
}

class _MainImageContainerState extends State<MainImageContainer> {
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
    context.read<EventBloc>().add(EventAddMainImage(path: _image!.path));
  }

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
            width: MediaQuery.of(context).size.width * 0.9,
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

class CustomImageContainer extends StatefulWidget {
  int index;
  CustomImageContainer({required this.index});
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
    switch (widget.index) {
      case 0:
        context.read<EventBloc>().add(EventAddImage1(path: _image!.path));

        break;

      case 1:
        context.read<EventBloc>().add(EventAddImage2(path: _image!.path));

        break;

      case 2:
        context.read<EventBloc>().add(EventAddImage3(path: _image!.path));

        break;
      default:
    }
  }

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

Widget buildPopUp(BuildContext context) {
  return AlertDialog(
    backgroundColor: Theme.of(context).secondaryBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    content: Container(
        height: 50.0.h,
        child: Column(
          children: [
            Container(
              height: 15.0.h,
              child: Image.asset(
                'assets/congratulations.png',
                width: 20.0.w,
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Container(
              height: 4.0.h,
              child: Text(
                "Congratulations!",
                style: GoogleFonts.raleway(fontSize: 20.0.sp),
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Container(
              height: 7.0.h,
              child: Text(
                "Your event has successfully\nbeen created",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: Theme.of(context).feedTextSecondaryColor),
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            InkWell(
              onTap: () {
                Share.share('Check out my event :  https://example.com');
              },
              child: Container(
                height: 6.0.h,
                child: Text(
                  "Share with socials",
                  style: GoogleFonts.raleway(fontSize: 15.0.sp),
                ),
              ),
            ),
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

Widget buildPopUp2(BuildContext context) {
  return AlertDialog(
    backgroundColor: Theme.of(context).secondaryBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    content: Container(
        height: 50.0.h,
        child: Column(
          children: [
            Text(
                "We have to sent you an email, Please verify to proceed ..... "),
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
                  "Sign Up",
                  style: GoogleFonts.raleway(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textSecondaryColor),
                ),
              ),
            ),
          ],
        )),
  );
}
