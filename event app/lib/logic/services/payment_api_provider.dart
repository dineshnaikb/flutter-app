// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:events/logic/services/payment_service.dart';
//
// import 'package:http/http.dart' as http;
//
// class APIProvider {
//   static String baseUrl = 'https://api.stripe.com/v1';
//   static String accessToken =
//       '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';
//   Dio dio = Dio();
//
//   _myHeaders() {
//     return {"Authorization": "Bearer $accessToken"};
//   }
//
//   // Future<String> createCustomerAndGetIdAsync(Customer customer) async {
//   //   Map<String, dynamic> body = {
//   //     'name': customer.name,
//   //     'email': customer.email,
//   //     'shipping[phone]': customer.shipping.phone,
//   //     'shipping[name]': customer.shipping.name,
//   //     'shipping[address][line1]': customer.shipping.address.line1,
//   //     'shipping[address][city]': customer.shipping.address.city,
//   //     'shipping[address][state]': customer.shipping.address.state,
//   //     'shipping[address][country]': customer.shipping.address.country,
//   //     'shipping[address][postal_code]': customer.shipping.address.postalCode,
//   //   };
//   //
//   //   var response = await http.post('$baseUrl/customers',
//   //       body: body, headers: StripeService.headers);
//   //   if (response.statusCode == 200) {
//   //     final Map<String, dynamic> rawData = jsonDecode(response.body);
//   //     return rawData['id'];
//   //   }
//   //   throw DioErrorType;
//   // }
//   //
//   // Future<String> createOrderAndGetIdAsync(Order order) async {
//   //   Map<String, dynamic> body = {
//   //     'currency': 'usd',
//   //     'email': order.email,
//   //     'items[0][type]': 'sku',
//   //     'items[0][parent]': order.items[0].parent,
//   //     'shipping[name]': order.shipping.name,
//   //     'shipping[phone]': order.shipping.phone,
//   //     'shipping[address][line1]': order.shipping.address.line1,
//   //     'shipping[address][city]': order.shipping.address.city,
//   //     'shipping[address][state]': order.shipping.address.state,
//   //     'shipping[address][country]': order.shipping.address.country,
//   //     'shipping[address][postal_code]': order.shipping.address.postalCode,
//   //     'customer': order.customer,
//   //     // 'metadata[size]' : order.metadata.size ,
//   //     'metadata[gender]': order.metadata.gender,
//   //     'metadata[age]': order.metadata.age,
//   //     'metadata[note]': order.metadata.note,
//   //   };
//   //   var response = await http.post('$baseUrl/orders',
//   //       body: body, headers: StripeService.headers);
//   //   if (response.statusCode == 200) {
//   //     final Map<String, dynamic> rawData = jsonDecode(response.body);
//   //     return rawData['id'];
//   //   }
//   //   throw DioErrorType;
//   // }
// }
