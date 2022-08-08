import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:events/logic/bloc/event_bloc.dart';

class EventDisplayRepository {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<EventState>> getMyEvents(String id, Map user_data) async* {
    List<EventState> res = [];
    try {
      // print(user_data);
      var formData = FormData.fromMap(
          {'userid': user_data['id'], 'password': user_data['tocken']});

      Response response = await Dio().get(
          'https://nextopay.com/uploop/events?userid=${user_data['user_id']}&token=${user_data['tocken']}&created_by=${user_data['user_id']}');

      // if (jsonDecode(response.data)["status"] == "1") {
      var resData = jsonDecode(response.data);
      // print('response');
      // print(resData);

      if (resData["status"] == "1") {
        List events = resData["data"].toList();
        events.forEach((element) {
          switch (element['event_date'].toString().substring(0, 3)) {
            case 'Jan':
              if (DateTime.now().month > 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Feb':
              if (DateTime.now().month > 2)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Mar':
              if (DateTime.now().month > 3)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Apr':
              if (DateTime.now().month > 4)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'May':
              if (DateTime.now().month > 5)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jun':
              if (DateTime.now().month > 6)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jul':
              if (DateTime.now().month > 7)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Aug':
              if (DateTime.now().month > 8)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Sep':
              if (DateTime.now().month > 9)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Nov':
              if (DateTime.now().month > 10)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Dec':
              if (DateTime.now().month > 11)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jan':
              if (DateTime.now().month == 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
          }
          element['isCurrUserEvent'] = true;
          res.add(EventState.fromMap(element));
        });
      } else {
        // res = resData["message"];
      }
      // } else {
      //   res = "some thing is wrong from us, please try again";
      //   print(res);
      // }
    } catch (e) {
      print('Error');
      print(e);
    }

    yield res;
    // return _firestore.collection('events').snapshots().map((snapshot) {
    //   return snapshot.docs.map((e) => EventState.fromMap(e.data())).toList();
    // });
  }

  Stream<List<EventState>> getAllEvents(String id, Map user_data) async* {
    List<EventState> res = [];
    try {
      // print(user_data);
      var formData = FormData.fromMap(
          {'userid': user_data['id'], 'password': user_data['tocken']});
      Response response = await Dio().get(
          'https://nextopay.com/uploop/events?userid=${user_data['user_id']}&token=${user_data['tocken']}');

      // if (jsonDecode(response.data)["status"] == "1") {
      var resData = jsonDecode(response.data);
      // print('response');
      // print(resData);

      if (resData["status"] == "1") {
        List events = resData["data"].toList();
        events.forEach((element) {
          if (element['created_by'][0]['user_id'] == user_data['user_id'])
            element['isCurrUserEvent'] = true;
          else
            element['isCurrUserEvent'] = false;
          switch (element['event_date'].toString().substring(0, 3)) {
            case 'Jan':
              if (DateTime.now().month > 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Feb':
              if (DateTime.now().month > 2)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Mar':
              if (DateTime.now().month > 3)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Apr':
              if (DateTime.now().month > 4)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'May':
              if (DateTime.now().month > 5)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jun':
              if (DateTime.now().month > 6)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jul':
              if (DateTime.now().month > 7)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Aug':
              if (DateTime.now().month > 8)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Sep':
              if (DateTime.now().month > 9)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Nov':
              if (DateTime.now().month > 10)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Dec':
              if (DateTime.now().month > 11)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jan':
              if (DateTime.now().month == 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
          }
          if (element['event_status'] == "Published") {
            print(EventState.fromMap(element).event_map);
            // print(element);
            res.add(EventState.fromMap(element));
            print('------------------------------------');
          }
        });
      } else {
        // res = resData["message"];
      }
      // } else {
      //   res = "some thing is wrong from us, please try again";
      //   print(res);
      // }
    } catch (e) {
      print('Error');
      print(e);
    }

    yield res;
    // return _firestore.collection('events').snapshots().map((snapshot) {
    //   return snapshot.docs.map((e) => EventState.fromMap(e.data())).toList();
    // });
  }

  Stream<List<Map>> getAllUpcomming(String id, Map user_data) async* {
    List<Map> res = [];
    try {
      Response response = await Dio().get(
          'https://nextopay.com/uploop/upcomming_events.php?type=1&user_id=${user_data['user_id']}');

      // if (jsonDecode(response.data)["status"] == "1") {
      var resData = jsonDecode(response.data);
      print('Fetching my events');
      print('response');
      print(resData);

      if (resData["status"] == "1") {
        List events = resData["data"].toList();

        events.forEach((element) {
          switch (element['event_date'].toString().substring(0, 3)) {
            case 'Jan':
              if (DateTime.now().month > 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Feb':
              if (DateTime.now().month > 2)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Mar':
              if (DateTime.now().month > 3)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Apr':
              if (DateTime.now().month > 4)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'May':
              if (DateTime.now().month > 5)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jun':
              if (DateTime.now().month > 6)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jul':
              if (DateTime.now().month > 7)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Aug':
              if (DateTime.now().month > 8)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Sep':
              if (DateTime.now().month > 9)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Nov':
              if (DateTime.now().month > 10)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Dec':
              if (DateTime.now().month > 11)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jan':
              if (DateTime.now().month == 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
          }
          if (element['created_by'][0]['user_id'] == user_data['user_id'])
            element['isCurrUserEvent'] = true;
          else
            element['isCurrUserEvent'] = false;
          print(element);
          res.add(element);
        });
      } else {
        // res = resData["message"];
      }
      // } else {
      //   res = "some thing is wrong from us, please try again";
      //   print(res);
      // }
    } catch (e) {
      print('Error');
      print(e);
    }

    yield res;
    // return _firestore.collection('events').snapshots().map((snapshot) {
    //   return snapshot.docs.map((e) => EventState.fromMap(e.data())).toList();
    // });
  }

  Stream<List<Map>> getAllPending(String id, Map user_data) async* {
    List<Map> res = [];
    try {
      Response response = await Dio().get(
          'https://nextopay.com/uploop/upcomming_events.php?type=0&user_id=${user_data['user_id']}');

      // if (jsonDecode(response.data)["status"] == "1") {
      var resData = jsonDecode(response.data);
      print('Fetching my events');
      print('response');
      print(resData);

      if (resData["status"] == "1") {
        List events = resData["data"].toList();
        events.forEach((element) {
          switch (element['event_date'].toString().substring(0, 3)) {
            case 'Jan':
              if (DateTime.now().month > 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Feb':
              if (DateTime.now().month > 2)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Mar':
              if (DateTime.now().month > 3)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Apr':
              if (DateTime.now().month > 4)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'May':
              if (DateTime.now().month > 5)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jun':
              if (DateTime.now().month > 6)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jul':
              if (DateTime.now().month > 7)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Aug':
              if (DateTime.now().month > 8)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Sep':
              if (DateTime.now().month > 9)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Nov':
              if (DateTime.now().month > 10)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Dec':
              if (DateTime.now().month > 11)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jan':
              if (DateTime.now().month == 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
          }
          if (element['created_by'][0]['user_id'] == user_data['user_id'])
            element['isCurrUserEvent'] = true;
          else
            element['isCurrUserEvent'] = false;
          print(element);
          res.add(element);
        });
      } else {
        // res = resData["message"];
      }
      // } else {
      //   res = "some thing is wrong from us, please try again";
      //   print(res);
      // }
    } catch (e) {
      print('Error');
      print(e);
    }
    log('Pending Events');
    log(res.toString());
    yield res;
    // return _firestore.collection('events').snapshots().map((snapshot) {
    //   return snapshot.docs.map((e) => EventState.fromMap(e.data())).toList();
    // });
  }

  Stream<List<EventState>> getAllRecommendedEvents(
      String id, Map user_data) async* {
    List<EventState> res = [];
    try {
      // print(user_data);
      var formData = FormData.fromMap(
          {'userid': user_data['id'], 'password': user_data['tocken']});
      Response response = await Dio().get(
          'https://nextopay.com/uploop/events?userid=${user_data['user_id']}&token=${user_data['tocken']}&recomend=YES');

      // if (jsonDecode(response.data)["status"] == "1") {
      var resData = jsonDecode(response.data);
      // print('response');
      // print(resData);

      if (resData["status"] == "1") {
        List events = resData["data"].toList();
        events.forEach((element) {
          switch (element['event_date'].toString().substring(0, 3)) {
            case 'Jan':
              if (DateTime.now().month > 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Feb':
              if (DateTime.now().month > 2)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Mar':
              if (DateTime.now().month > 3)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Apr':
              if (DateTime.now().month > 4)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'May':
              if (DateTime.now().month > 5)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jun':
              if (DateTime.now().month > 6)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jul':
              if (DateTime.now().month > 7)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Aug':
              if (DateTime.now().month > 8)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Sep':
              if (DateTime.now().month > 9)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Nov':
              if (DateTime.now().month > 10)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Dec':
              if (DateTime.now().month > 11)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
            case 'Jan':
              if (DateTime.now().month == 1)
                element['isCurrEvent'] = false;
              else
                element['isCurrEvent'] = true;
              break;
          }
          if (element['created_by'][0]['user_id'] == user_data['user_id'])
            element['isCurrUserEvent'] = true;
          else
            element['isCurrUserEvent'] = false;
          res.add(EventState.fromMap(element));
        });
      } else {
        // res = resData["message"];
      }
      // } else {
      //   res = "some thing is wrong from us, please try again";
      //   print(res);
      // }
    } catch (e) {
      print('Error');
      print(e);
    }

    yield res;
    // return _firestore.collection('events').snapshots().map((snapshot) {
    //   return snapshot.docs.map((e) => EventState.fromMap(e.data())).toList();
    // });
  }
}
