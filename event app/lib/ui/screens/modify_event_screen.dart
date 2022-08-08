import 'dart:convert';
import 'dart:io';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/event_bloc.dart';
import 'package:events/logic/bloc/form_submission.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:events/ui/screens/create_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    CreateEventScreen.type = [];
    tags.forEach((element) {
      CreateEventScreen.type.add(element['tags_name']);
    });
    setState(() {});
  }

  @override
  void initState() {
    context.read<EventBloc>().add(EventEditInitial(eventToEdit: event));
    // _image = File(image!.path);
    // context.read<EventBloc>().add(EventAddEventDate(date: event.event_date));
    super.initState();
  }

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
    event = ModalRoute.of(context)!.settings.arguments as EventState;

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
                builder: (BuildContext context) =>
                    buildPopUp(context, context.watch<EventBloc>().state));
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
                    child: MainImageContainer(
                      imagePath: event.img1,
                    ),
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
                    initialValue: event.title,
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

                  TextFormField(
                    initialValue: event.place,
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
                    initialValue: event.video_url,
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
                    values: CreateEventScreen.type,
                    itemTitle: CreateEventScreen.type,
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
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter event date';
                  //     }
                  //   },
                  //   onChanged: (value) {
                  //     context
                  //         .read<EventBloc>()
                  //         .add(EventAddEventDate(date: value));
                  //   },
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.all(20),
                  //     filled: true,
                  //     hintMaxLines: 2,
                  //     fillColor: Theme.of(context).textFieldColor,
                  //     border: OutlineInputBorder(
                  //         borderSide: BorderSide.none,
                  //         borderRadius: BorderRadius.circular(25)),
                  //     hintText: 'Please specify event date',
                  //   ),
                  // ),
                  InkWell(
                    onTap: () async {
                      final DateTime? eventDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        initialEntryMode: DatePickerEntryMode.calendar,
                      );
                      if (eventDate != null) {
                        String formattedDate =
                            '${eventDate.day}-${eventDate.month}-${eventDate.year}';
                        context
                            .read<EventBloc>()
                            .add(EventAddEventDate(date: formattedDate));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).textFieldColor,
                          borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 6.0.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(context
                                    .watch<EventBloc>()
                                    .state
                                    .event_date
                                    .isEmpty
                                ? event.event_date
                                : context.watch<EventBloc>().state.event_date),
                            Icon(Icons.date_range)
                          ],
                        ),
                      ),
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
                                          .from_time
                                          .isEmpty
                                      ? event.from_time
                                      : context
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
                              Text(context
                                      .watch<EventBloc>()
                                      .state
                                      .to_time
                                      .isEmpty
                                  ? event.to_time
                                  : context.watch<EventBloc>().state.to_time),
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
                    initialValue: event.food_bev,
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
                    initialValue: event.comments,
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
                          "Private",
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
                          initialValue: event.male_price,
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
                          initialValue: event.female_price,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text(
                  //         "This is a virtual event",
                  //         style: GoogleFonts.raleway(
                  //             fontSize: 15.0.sp,
                  //             color: Theme.of(context).textPrimaryColor),
                  //       ),
                  //     ),
                  //     FlutterSwitch(
                  //       width: 14.0.w,
                  //       height: 4.0.h,
                  //       valueFontSize: 25.0,
                  //       toggleSize: 6.0.w,
                  //       activeColor: Color.fromRGBO(38, 174, 101, 1),
                  //       value: context.watch<EventBloc>().state.virtual_event,
                  //       borderRadius: 30.0,
                  //       showOnOff: false,
                  //       onToggle: (val) {
                  //         context
                  //             .read<EventBloc>()
                  //             .add(EventToggleVirtualEvent(enabled: val));
                  //       },
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5.0.h,
                  // ),
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     "COVID 19",
                  //     style: GoogleFonts.raleway(
                  //         fontSize: 15.0.sp,
                  //         color: Theme.of(context).textPrimaryColor),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 2.0.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.all(20),
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //               color: Theme.of(context).textPrimaryColor),
                  //           borderRadius: BorderRadius.circular(30)),
                  //       child: Text("Vaccine Proof",
                  //           style: GoogleFonts.raleway(
                  //               fontSize: 12.0.sp,
                  //               color: Theme.of(context).textPrimaryColor)),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.all(20),
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //               color: Theme.of(context).textPrimaryColor),
                  //           borderRadius: BorderRadius.circular(30)),
                  //       child: Text("PCR Test Required",
                  //           style: GoogleFonts.raleway(
                  //               fontSize: 12.0.sp,
                  //               color: Theme.of(context).textPrimaryColor)),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5.0.h,
                  // ),
                  // SizedBox(
                  //   height: 2.0.h,
                  // ),
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

class MainImageContainer extends StatefulWidget {
  String? imagePath;
  MainImageContainer({this.imagePath});
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
  void initState() {
    _image = File(widget.imagePath!);

    // TODO: implement initState
    super.initState();
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
            child: _image == null && widget.imagePath == null
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
                : widget.imagePath != null
                    ? Image.network(
                        widget.imagePath!,
                        fit: BoxFit.cover,
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
