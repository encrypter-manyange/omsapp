import 'package:flutter/cupertino.dart';
import 'package:witness_project/src/models/AuthModel.dart';

import '../models/UserModel.dart';

String appEmail="admin@oms.com";
String appPassword="Sodium2195!";
ValueNotifier<UserModel?> user=ValueNotifier(null);
ValueNotifier<AuthModel?> auth=ValueNotifier(null);