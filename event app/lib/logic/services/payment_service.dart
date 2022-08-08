import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController {
  Map<String, dynamic>? paymentIntentData;
  String paymentIntentId = '';
  Future<String> createStripeClient() async {
    print('stripe client');
    var uname = 'sk_test_qEerL9FrbK09VgoYJ7kWdgCe00ilyZnTDl';
    var pword = '';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var url = Uri.parse('https://api.stripe.com/v1/customers');
    var res = await http.post(url, headers: {'Authorization': authn});
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);
    return json.decode(res.body)['id'];
  }

  Future<String> createEphermalKey(String clientId) async {
    var uname = 'sk_test_qEerL9FrbK09VgoYJ7kWdgCe00ilyZnTDl';
    var pword = '';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'Stripe-Version': '2020-08-27',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': authn,
    };

    var data = 'customer=$clientId';

    var url = Uri.parse('https://api.stripe.com/v1/ephemeral_keys');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);
    return json.decode(res.body)['id'];
  }

  Future<String> createClientSecret(String clientId, String amount) async {
    var uname = 'sk_test_qEerL9FrbK09VgoYJ7kWdgCe00ilyZnTDl';
    var pword = '';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': authn,
    };

    var data = {
      'customer': '$clientId',
      'amount': '$amount',
      'currency': 'USD',
      'automatic_payment_methods[enabled]': 'true',
    };

    var url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);
    paymentIntentId = json.decode(res.body)['id'];
    return json.decode(res.body)['client_secret'];
  }

  Future<void> makePayment(
      {required String amount,
      required String currency,
      required String eventId,
      required BuildContext context}) async {
    try {
      print(amount);
      print(currency);
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        Stripe.publishableKey =
            await 'pk_test_f50Aag6PNA60Wew1rjvwVfcb00VP6Jv9jD';
        print('Key Set');
        await Stripe.instance.applySettings();
        String customerId = await createStripeClient();
        String ephemeralKey = await createEphermalKey(customerId);
        String client_secret = await createClientSecret(customerId, amount);

        print(customerId);
        print(ephemeralKey);
        print(client_secret);
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: customerId,
          paymentIntentClientSecret: client_secret,
          customerEphemeralKeySecret: ephemeralKey,
        ));
        print('Displaying Sheet');
        await Stripe.instance.presentPaymentSheet(
            // parameters: PresentPaymentSheetParameters(
            //     clientSecret: paymentIntentData!['client_secret'])
            );
        print('Sheet Displayed');
        //======Check Payment

        // var uname =
        //     'sk_test_51L0r4NH4wNzZIiLAkcYA7weoNxQpCLIxWHqxqLQqI92PVw3wHwwQ8oqVPUuCJyoCwYaFrYOdYAIpgHrZDOaFq3ZE00Kx8x9dDX';
        // var pword = '';
        // var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));
        // var headers = {
        //   'Content-Type': 'application/x-www-form-urlencoded',
        //   'Authorization': authn,
        // };
        // var data = 'payment_method=pm_card_visa';
        //
        // var url = Uri.parse(
        //     'https://api.stripe.com/v1/payment_intents/$paymentIntentId/confirm');
        // var res = await http.post(url, headers: headers, body: data);
        // if (res.statusCode != 200) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('Error Occured'),
        //     ),
        //   );
        //   throw Exception('http.post error: statusCode= ${res.statusCode}');
        // } else {
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        print(_prefs.getString("user_obj"));
        Response response = await Dio().get(
            'https://nextopay.com/uploop/success_payment?event_id=$eventId&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}&amount=$amount&trans_id=1212&status=0');
        var resData = jsonDecode(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(resData['message'].toString()),
          ),
        );
        // }
        print(response.data);
      }
    } catch (e, s) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      }
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      print('Payment Successfull');
      // Get.snackbar('Payment', 'Payment Successful',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     margin: const EdgeInsets.all(10),
      //     duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'sk_test_51L0r4NH4wNzZIiLAkcYA7weoNxQpCLIxWHqxqLQqI92PVw3wHwwQ8oqVPUuCJyoCwYaFrYOdYAIpgHrZDOaFq3ZE00Kx8x9dDX',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
