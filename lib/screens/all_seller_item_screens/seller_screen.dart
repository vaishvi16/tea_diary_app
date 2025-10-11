import 'package:flutter/material.dart';
import 'package:tea_diary_app/custom_colors/custom_colors.dart';
import 'package:tea_diary_app/custom_widgets/custom_appbar.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: false,
        centerTitle: false,
        title: Text("Seller List"),
        actions: [Icon(Icons.add, color: CustomColors.whiteColor)],
      ),
    );
  }
}
