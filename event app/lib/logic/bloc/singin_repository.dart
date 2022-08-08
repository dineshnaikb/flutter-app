import 'dart:convert';

import 'package:events/core/login.dart';
import 'package:events/core/user.dart';
import 'package:events/logic/bloc/eventuser_bloc.dart';
import 'package:events/model/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninRepository {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login(String email, String password, String profile) async {
    // String res = await Login.SignInWithEmailPassword(email: email, password: password);
    // print("see " + res);

    // final CollectionReference _mainCollection = _firestore.collection('users');
    // if (res == "success") {
    //   String id = _mainCollection.doc().id;

    //   var snapshot =
    //       await _mainCollection.where('email', isEqualTo: email).get();
    //   Map<String, dynamic> xyz =
    //       snapshot.docs.first.data() as Map<String, dynamic>;
    //   String profileType = EventuserState.fromMap(xyz).profile;
    //   print(profile + profileType);
    //   if (profileType != profile) {
    //     return "Select the correct profile";
    //   }
    // }

    String res = "";
    try {
      var formData = FormData.fromMap({"user_id": email, "password": password});
      Response response =
          await Dio().post('https://nextopay.com/uploop/login', data: formData);

      if (response.statusCode == 200) {
        var resData = jsonDecode(response.data);
        if (resData["status"] == "1") {
          res = "success";
          var appuser = AppUserModel.fromJson(resData["data"].toList()[0]);
          final SharedPreferences _prefs =
              await SharedPreferences.getInstance();
          _prefs.setString("user_id", appuser.userId ?? "");
          _prefs.setString("user_obj", jsonEncode(appuser.toJson()));
        } else {
          res = resData["message"];
        }
      } else {
        res = "some thing is wrong from us, please try again";
      }
    } catch (e) {
      res = "some thing is wrong from us, please try again";
      print(e);
    }

    return res;
  }

  Future<dynamic> createUser(String email, String password) async {
    // try {
    //   UserCredential res = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    //   final user = EventUser(email: email);

    //   print(res);

    //   await res.user!.sendEmailVerification();

    //   return res;
    // } catch (e) {
    //   return e;
    // }

    String res = "";
    try {
      var formData = FormData.fromMap(
          {'email': email, 'password': password, 'rpass': password});
      Response response = await Dio()
          .post('https://nextopay.com/uploop/register', data: formData);

      // if (jsonDecode(response.data)["status"] == "1") {
      var resData = jsonDecode(response.data);
      print('response');
      print(resData);
      print(formData.fields);

      if (resData["status"] == "1") {
        res = "success";
        var appuser = AppUserModel.fromJson(resData["data"].toList()[0]);
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString("user_id", appuser.userId ?? "");
        _prefs.setString("user_obj", jsonEncode(appuser.toJson()));
      } else {
        res = resData["message"];
      }
      // } else {
      //   res = "some thing is wrong from us, please try again";
      //   print(res);
      // }
    } catch (e) {
      res = "User Created Successfully";
      print('Error');
      print(e);
    }

    return res;
  }
}
