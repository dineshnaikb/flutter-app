import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:events/logic/bloc/form_submission.dart';
import 'package:events/logic/bloc/settings_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventState());
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    // final CollectionReference _mainCollection = _firestore.collection('events');
    if (event is EventInitial) {
      yield EventState(
          uid: event.uid,
          photo_url: event.photo_url,
          offering_option: 'General Admission',
          virtual_event: false,
          paid_event: false,
          created_date:
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
    } else if (event is EventEditInitial) {
      yield EventState.fromMap(event.eventToEdit.toMap());
    } else if (event is EventAddImage1) {
      // final _firebaseStorage = FirebaseStorage.instance;

      var file = File(event.path);

      // var snapshot_img = await _firebaseStorage
      //     .ref()
      //     .child('images/events/${FirebaseAuth.instance.currentUser?.uid}')
      //     .putFile(file);

      // var downloadUrl = await snapshot_img.ref.getDownloadURL();
      // print(downloadUrl);
      // print(event.path);
      yield state.copyWith(img2: event.path);
    } else if (event is EventAddImage2) {
      print(event.path);
      yield state.copyWith(img3: event.path);
    } else if (event is EventAddMainImage) {
      print(event.path);
      yield state.copyWith(img1: event.path);
    } else if (event is EventAddImage3) {
      print(event.path);
      yield state.copyWith(img4: event.path);
    } else if (event is EventAddtitle) {
      print(event.title);
      yield state.copyWith(title: event.title);
    } else if (event is EventAddPlace) {
      print(event.place);
      yield state.copyWith(place: event.place);
    } else if (event is EventAddVideo) {
      print(event.link);
      yield state.copyWith(video_url: event.link);
    } else if (event is EventAddOfferingOption) {
      print(event.option);
      yield state.copyWith(offering_option: event.option);
    } else if (event is EventAddType) {
      print(event.types);
      yield state.copyWith(type: event.types);
    } else if (event is EventToggleUserInInvitedList) {
      print(event.user);
      List<String> invitedList = state.invitedFriends.toList(growable: true);
      if (state.invitedFriends.contains(event.user))
        invitedList.remove(event.user);
      else
        invitedList.add(event.user);
      yield state.copyWith(invitedFriends: invitedList);
    } else if (event is EventToggleUserInCoshareList) {
      print(event.user);
      List<String> coShareList = state.coShareList.toList(growable: true);
      if (state.coShareList.contains(event.user))
        coShareList.remove(event.user);
      else
        coShareList.add(event.user);
      print(coShareList);
      yield state.copyWith(coShareList: coShareList);
    } else if (event is EventAddFromTime) {
      print(event.time);
      yield state.copyWith(from_time: event.time);
    } else if (event is EventAddToTime) {
      print(event.time);
      yield state.copyWith(to_time: event.time);
    } else if (event is EventAddFoodAndBeverage) {
      print(event.text);
      yield state.copyWith(event_tags: event.text);
    } else if (event is EventAddEventDate) {
      print(event.date);
      yield state.copyWith(event_date: event.date);
    } else if (event is EventAddFromAge) {
      print(event.age);
      yield state.copyWith(from_age: event.age);
    } else if (event is EventAddToAge) {
      print(event.age);
      yield state.copyWith(to_age: event.age);
    } else if (event is EventAddComments) {
      print(event.comment);
      yield state.copyWith(comments: event.comment);
    } else if (event is EventAddFoodAndBeverage) {
      print(event.text);
      yield state.copyWith(food_bev: event.text);
    } else if (event is EventTogglePaidEvent) {
      print('paid ${event.enabled}');

      print(event.enabled);
      yield state.copyWith(paid_event: event.enabled);
    } else if (event is EventAddComments) {
      print(event.comment);
      yield state.copyWith(comments: event.comment);
    } else if (event is EventAddMalePrice) {
      print(event.price);
      yield state.copyWith(male_price: event.price);
    } else if (event is EventAddFemalePrice) {
      print(event.price);
      yield state.copyWith(female_price: event.price);
    } else if (event is EventAddMaleNo) {
      print(event.no);
      yield state.copyWith(male_no: event.no);
    } else if (event is EventAddFemaleNo) {
      print(event.no);
      yield state.copyWith(female_no: event.no);
    } else if (event is EventSubmitted) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());

      // String id = _mainCollection.doc().id;

      // final _firebaseStorage = FirebaseStorage.instance;

      if (state.img1 != '') {
        var file1 = File(state.img1);

        // var snapshot_img1 = await _firebaseStorage
        //     .ref()
        //     .child('images/events/${id}/1')
        //     .putFile(file1);

        // var downloadUrl1 = await snapshot_img1.ref.getDownloadURL();
        // print(downloadUrl1);
        // yield state.copyWith(img1: downloadUrl1);
      }

      if (state.img2 != '') {
        // var file2 = File(state.img2);

        // var snapshot_img2 = await _firebaseStorage
        //     .ref()
        //     .child('images/events/${id}/2')
        //     .putFile(file2);

        // var downloadUrl2 = await snapshot_img2.ref.getDownloadURL();
        // print(downloadUrl2);
        // yield state.copyWith(img2: downloadUrl2);
      }

      if (state.img3 != '') {
        // var file2 = File(state.img3);

        // var snapshot_img3 = await _firebaseStorage
        //     .ref()
        //     .child('images/events/${id}/3')
        //     .putFile(file2);

        // var downloadUrl3 = await snapshot_img3.ref.getDownloadURL();
        // print(downloadUrl3);
        // yield state.copyWith(img3: downloadUrl3);
      }
      try {
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        print(_prefs.getString("user_id"));
        print(_prefs.getString("user_obj"));
        var file = File(state.img1);
        String fileName = file.path.split('/').last;
        print('Paid ${state.paid_event}');
        print('Private ${state.virtual_event}');
        FormData formData = new FormData.fromMap({
          'event_tittle': state.title,
          'event_place': state.place,
          'vurllink': state.video_url,
          'of_option': state.offering_option,
          'event_type': state.type,
          'start_time': state.from_time,
          'end_time': state.to_time,
          'food_bev': state.food_bev,
          'age_from': state.from_age,
          'age_to': state.to_age,
          'comments': state.comments,
          'private': state.virtual_event == true ? '1' : '0',
          'paid_event': state.paid_event == true ? '1' : '0',
          'male_p': state.male_price,
          'female_p': state.female_price,
          'm_count': state.male_no,
          'f_count': state.female_no,
          "file": await MultipartFile.fromFile(file.path, filename: fileName),
          'user_id': json.decode(_prefs.getString("user_obj")!)['user_id'],
          'tocken': json.decode(_prefs.getString("user_obj")!)['tocken'],
          'event_date': state.event_date
        });

        print(formData.fields);
        Response response = await Dio()
            .post('https://nextopay.com/uploop/create_event', data: formData);
        print(response.data);
        String newEventID =
            json.decode(response.data)['data'].toList()[0]["event_id"];
        if (state.img2 != '') {
          var file2 = File(state.img2);
          String fileName2 = file2.path.split('/').last;
          FormData formData2 = FormData.fromMap({
            'event_id': newEventID,
            "file":
                await MultipartFile.fromFile(file2.path, filename: fileName2),
          });
          Response response2 = await Dio().post(
              'https://nextopay.com/uploop/upload_event_pic',
              data: formData2);
          print(response2.data);
        }

        if (state.img3 != '') {
          var file3 = File(state.img3);
          String fileName3 = file3.path.split('/').last;
          FormData formData3 = FormData.fromMap({
            'event_id': newEventID,
            "file":
                await MultipartFile.fromFile(file3.path, filename: fileName3),
          });
          Response response3 = await Dio().post(
              'https://nextopay.com/uploop/upload_event_pic',
              data: formData3);
          print(response3.data);
        }

        if (state.img4 != '') {
          var file4 = File(state.img4);
          String fileName4 = file4.path.split('/').last;
          FormData formData4 = FormData.fromMap({
            'event_id': newEventID,
            "file":
                await MultipartFile.fromFile(file4.path, filename: fileName4),
          });
          Response response4 = await Dio().post(
              'https://nextopay.com/uploop/upload_event_pic',
              data: formData4);
          print(response4.data);
        }

        state.coShareList.forEach((element) async {
          Response response = await Dio().post(
              'https://nextopay.com/uploop/co_share?user_id=$element&event_id=$newEventID');
          print(response.data);
        });
        state.invitedFriends.forEach((element) async {
          Response response = await Dio().post(
              'https://nextopay.com/uploop/invite_friends?event_id=$newEventID&user_id=${json.decode(_prefs.getString("user_obj")!)['user_id']}&frdid=$element');
          print(response.data);
        });

        // await _mainCollection.doc(id).set(state.toMap());
        yield state.copyWith(formSubmissionStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(
            formSubmissionStatus: SubmissionFailed(exception: e.toString()));
      }
    } else if (event is EventToggleVirtualEvent) {
      print('private ${event.enabled}');
      yield state.copyWith(virtual_event: event.enabled);
    } else if (event is EventComplete) {
      yield EventState();
    }
  }
}
