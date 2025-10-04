import 'package:flutter/material.dart';
import 'package:tea_diary_app/custom_colors/custom_colors.dart';
import 'package:tea_diary_app/custom_widgets/custom_appbar.dart';
import 'package:tea_diary_app/custom_widgets/custom_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Text("Tea Diary", style: TextStyle(color: CustomColors.whiteColor),),
          centerTitle: false),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primaryColor,
        onPressed: () {},
      child: Icon(Icons.share, color: CustomColors.whiteColor,),
      ),
    );
  }
}
