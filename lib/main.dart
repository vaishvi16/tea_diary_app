import 'package:flutter/material.dart';
import 'package:tea_diary_app/custom_colors/custom_colors.dart';
import 'package:tea_diary_app/screens/dashboard_screen/dashboard_screen.dart';
import 'package:tea_diary_app/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: CustomColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: CustomColors.primaryColor,
          secondary: CustomColors.primaryLightColor,
        ),
      ),
      home: SplashScreen()));
}
