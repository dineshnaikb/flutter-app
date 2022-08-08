import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:events/core/app_theme.dart';
import 'package:events/logic/bloc/payments_bloc.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:events/logic/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

import '../../logic/bloc/event_bloc.dart';

class EventDetailsScreen extends StatefulWidget {
  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventState event = EventState();
  Map userData = {};
  // Future<void> makePayment() async {
  //   try {
  //     /// call Payment intent api
  //     await callPaymentIntentAPI(price: event.male_price);
  //
  //     /// Payment sheet initialization
  //     await initPaymentSheet();
  //
  //     /// Now finally display payment sheet
  //     await displayPaymentSheet();
  //   } catch (e) {
  //     print('Exception : ' + e.toString());
  //   }
  // }
  //
  // var isProgress = false;
  // Map<String, dynamic>? paymentIntentData;
  // StripePaymentBloc stripePaymentBloc = StripePaymentBloc();
  //
  // Future<void> callPaymentIntentAPI({required String price}) async {
  //   isProgress = true;
  //   paymentIntentData = await stripePaymentBloc.callPaymentIntent(
  //     event.male_price,
  //     'INR',
  //   );
  //   isProgress = false;
  // }
  //
  // Future<String> initPaymentSheet() async {
  //   try {
  //     return await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //                 paymentIntentClientSecret:
  //                     paymentIntentData!['client_secret'],
  //                 applePay: true,
  //                 googlePay: true,
  //                 testEnv: true,
  //                 style: ThemeMode.dark,
  //                 currencyCode: 'inr',
  //                 merchantCountryCode: 'IND',
  //                 merchantDisplayName: 'Uploop'))
  //         .then((value) {
  //       print("Success initPaymentSheet ");
  //       return 'Success';
  //     }).onError((error, stackTrace) {
  //       print("Error initPaymentSheet " + error.toString());
  //       return 'Error';
  //     });
  //   } catch (e) {
  //     print('Exception : ' + e.toString());
  //     return 'Exception';
  //   }
  // }
  //
  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((newValue) {
  //       print("Success Payment Successfully");
  //       // clearList();
  //       print('payment intent ===> ' + paymentIntentData!['id'].toString());
  //
  //       paymentIntentData = null;
  //     }).onError((error, stackTrace) {
  //       print('Exception onError ==> $error $stackTrace');
  //       // showSnackBar("Cancel", "Payment canceled");
  //     });
  //   } on StripeException catch (e) {
  //     print('Exception ==> $e');
  //     print("Exception Payment failed");
  //   } catch (e) {
  //     print('$e');
  //   }
  // }

  List<Widget> eventComments = [];
  fetchComments() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    print(_prefs.getString("user_obj"));
    print(event.uid);
    print(
        'https://nextopay.com/uploop/event_comments?event_id=${event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');
    Response response = await Dio().get(
        'https://nextopay.com/uploop/event_comments?event_id=${event.uid}&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}');

    log(response.data);
    if (json.decode(response.data)['message'] != 'No data exhist')
      json.decode(response.data)['data'].toList().forEach((element) {
        eventComments.add(Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 6.0.w,
                    backgroundImage: NetworkImage(
                        '${element['User_detail'].toList()[0]['Pic']}'),
                  ),
                  SizedBox(
                    width: 5.0.w,
                  ),
                  Text(
                    '${element['User_detail'].toList()[0]['Name']}',
                    style: GoogleFonts.raleway(),
                  ),
                  Spacer(),
                  Text(
                    '${element['date']}',
                    style: GoogleFonts.raleway(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0.w),
              //alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.0.h,
                  ),
                  Text(
                    '${element['comment']}',
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 1.0.h,
                  ),
                ],
              ),
            ),
          ],
        ));
      });

    setState(() {});
  }

  final PaymentController controller = PaymentController();

  @override
  void initState() {
    fetchComments();
    // StripeService.init();
    // Stripe.publishableKey =
    //     'pk_test_51L0r4NH4wNzZIiLAcxS0YtJHeBeFp3MPXR0b6dBicuPqqk3jLkTpKohChAtdyjkYhR1IGBWFDygmyODmBvvtvpW900Ln8mJdQR';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context)!.settings.arguments as EventState;
    userData = context.watch<SettingsBloc>().state.toMap();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBody: true,
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
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.0.h,
                  ),
                  Text(
                    event.title,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Container(
                    height: 5.0.h,
                    padding: EdgeInsets.only(left: 2.0.w),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: event.event_tags.split(',').length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Theme.of(context).textFieldColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(event.event_tags.split(',')[index],
                                style: GoogleFonts.raleway()),
                          );
                        }),
                  ),
                  // Wrap(
                  //   spacing: 2.0.w,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.all(12),
                  //       decoration: BoxDecoration(
                  //           color: Theme.of(context).textFieldColor,
                  //           borderRadius: BorderRadius.circular(30)),
                  //       child: Text("Crypto", style: GoogleFonts.raleway()),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.all(12),
                  //       decoration: BoxDecoration(
                  //           color: Theme.of(context).textFieldColor,
                  //           borderRadius: BorderRadius.circular(30)),
                  //       child: Text("Crypto", style: GoogleFonts.raleway()),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Container(
                      height: 30.0.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(
                              event.img1,
                            ),
                            fit: BoxFit.fill,
                          ))),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  // SizedBox(
                  //   height: 1.5.h,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/Date.svg',
                            color: Theme.of(context).appBarIconColor,
                          ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text(
                            event.event_date,
                            style: GoogleFonts.raleway(
                                color:
                                    Theme.of(context).feedTextSecondaryColor),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/Location.svg',
                            color: Theme.of(context).appBarIconColor,
                          ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text(
                            event.place,
                            style: GoogleFonts.raleway(
                                color:
                                    Theme.of(context).feedTextSecondaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  // Container(
                  //   child: Text(
                  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem vulputate enim sem nisl aliquet. Commodo purus placerat magnis iaculis aliquam, elit amet ipsum.",
                  //     style: GoogleFonts.raleway(fontSize: 12.0.sp),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 4.0.h,
                  // ),
                  Row(
                    children: [
                      Text(
                        "Age limit:",
                        style: GoogleFonts.raleway(
                            fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 3.0.w,
                      ),
                      Text(
                        "From ${event.from_age} age",
                        style: GoogleFonts.raleway(
                            fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 3.0.w,
                      ),
                      Text(
                        "To ${event.to_age} age",
                        style: GoogleFonts.raleway(
                            fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Price",
                        style: GoogleFonts.raleway(fontSize: 12.0.sp),
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        userData['sex'] == "Female"
                            ? "\$${event.female_price}"
                            : "\$${event.male_price}",
                        style: GoogleFonts.raleway(
                            fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  ...eventComments,
                  SizedBox(
                    height: 15.0.h,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () async {
                      print('Starting payment');
                      controller.makePayment(
                          amount: userData['sex'] == "Female"
                              ? "${double.parse(event.female_price).round() * 100}"
                              : "${double.parse(event.male_price).round() * 100}",
                          currency: 'USD',
                          eventId: event.uid,
                          context: context);

                      // final paymentMethod = await Stripe.instance
                      //     .createPaymentMethod(PaymentMethodParams.card(
                      //         paymentMethodData: PaymentMethodData()));
                      // Navigator.pushNamed(context, '/promote_screen');
                      // makePayment();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 6.0.h,
                      width: 40.8.w,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(135, 207, 217, 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        event.paid_event == true
                            ? userData['sex'] == "Female"
                                ? "Buy \$${event.female_price}"
                                : "Buy \$${event.male_price}"
                            : "Join Event",
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
          ),
        ],
      ),
    );
  }
}
