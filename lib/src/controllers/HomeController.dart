import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:witness_project/src/models/ContributionsModel.dart';
import 'package:witness_project/src/repositories/app_repository.dart';

class HomeController extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  bool loading = false;
  List<ContributionsModel> data = [];

  HomeController() {
   scaffoldKey =  GlobalKey<ScaffoldState>();
  }


  Future<void> reload()async {
    listenForContributions();
  }

  Future<void> listenForContributions() async {
    setState(() {
      loading = true;
    });
    final Stream<ContributionsModel> stream = await get_contributions();
    stream.listen((ContributionsModel contributionsModel) {
      setState(() {
        data.add(contributionsModel);
      });
    }, onError: (a) {
      setState(() {
        loading = false;
      });
    }, onDone: () {
      setState(() {
        loading = false;
      });
    });
  }
}