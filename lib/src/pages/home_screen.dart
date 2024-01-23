import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:witness_project/src/constants/app_colors.dart';
import 'package:witness_project/src/controllers/HomeController.dart';

import '../constants/app_strings.dart';
import '../constants/app_theme.dart';
import '../widgets/gradient_background.dart';

class HomeWidget extends StatefulWidget {

  const HomeWidget({super.key});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  late HomeController _con;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForContributions();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: const Text(AppStrings.contributions,style: AppTheme.bodySmall,),
        actions:  [InkWell(
            onTap: ()async{
              Navigator.of(context).pushReplacementNamed('login');
            },

            child: const Icon(Icons.logout,color: Colors.white,))],
      ),

      body: RefreshIndicator(
        onRefresh: ()async{
          _con.reload();
        },
        child: ListView(
          children: [
          _con.data.isEmpty?const Center(child: Text("No contributions found")):  ListView.separated(
                itemCount: _con.data.length,
                primary: false,
                shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider();
              },
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.monetization_on),
                      trailing:  Text(
                       "\$${ _con.data[index].amount??''}",
                        style: const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text(_con.data[index].description??""),
                    subtitle: Text(_con.data[index].status==1?"Paid":"Pending",style: AppTheme.bodySmall.copyWith(color:_con.data[index].status==1?Colors.green:Colors.red),),

                  );
                }),
          ],
        ),
      ),

    );
  }
}
