import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/Message.dart';
import '../repositories/app_repository.dart';
import '../repositories/user_repository.dart';

class LoginController extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  bool loading = false;
  LoginController() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  }
  void getAppToken() {
    setState(() {
      loading = true;
    });
    getToken().then((value) async {
      if (value != null) {
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        CustomMessageHandler().showErrorSnakeBar(scaffoldKey.currentContext!, "Something went wrong.Try again");
      }
    });
  }

  void loginUser(Map map) {
    setState(() {
      loading = true;
    });
    loginAppUser(map).then((value) async {
      if (value != null) {
        if (value.userModel != null) {
          user.value=value.userModel;
          user.notifyListeners();
          Navigator.of(scaffoldKey.currentContext!).pushReplacementNamed('dashboard');
        } else {
          setState(() {
            loading = false;
          });
          CustomMessageHandler().showErrorSnakeBar(scaffoldKey.currentContext!, value.message!);
        }

        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        CustomMessageHandler().showErrorSnakeBar(scaffoldKey.currentContext!, "Something went wrong.Try again");
      }
    });
  }

  void registerAppUser(Map map){
    setState(() {

      loading=true;
    });
    registerUser(map).then((value) async {
      if (value != null) {
        if (value.userModel != null) {
          user.value=value.userModel;
          user.notifyListeners();
          setState(() {
            loading = false;
          });
          Navigator.of(scaffoldKey.currentContext!).pushReplacementNamed('dashboard');
        } else {
          setState(() {
            loading = false;
          });
          CustomMessageHandler().showErrorSnakeBar(scaffoldKey.currentContext!, value.message!);
        }
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        CustomMessageHandler().showErrorSnakeBar(scaffoldKey.currentContext!, "Something went wrong.Try again");
      }
    });
  }

}
