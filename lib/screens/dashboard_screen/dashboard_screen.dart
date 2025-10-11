import 'package:flutter/material.dart';
import 'package:tea_diary_app/custom_colors/custom_colors.dart';
import 'package:tea_diary_app/custom_widgets/custom_appbar.dart';
import 'package:tea_diary_app/custom_widgets/custom_drawer.dart';

import '../../custom_widgets/custom_grid_view.dart';


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
        title: Text(
          "Tea Diary",
          style: TextStyle(color: CustomColors.whiteColor),
        ),
        centerTitle: false, implyLeading: true,
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: CustomColors.primaryColor,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("0", style: TextStyle(color: CustomColors.whiteColor,fontSize: 28, fontWeight: FontWeight.w700),),
                        Text("Tea/Coffee \n in November", style: TextStyle(color: CustomColors.whiteColor),),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: CustomColors.primaryColor,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("₹0", style: TextStyle(color: CustomColors.whiteColor,fontSize: 28, fontWeight: FontWeight.w700),),
                        Text("Amount in \nNovember", style: TextStyle(color: CustomColors.whiteColor),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: CustomGridView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primaryColor,
        onPressed: () {},
        child: Icon(Icons.share, color: CustomColors.whiteColor),
      ),
    );
  }
}
