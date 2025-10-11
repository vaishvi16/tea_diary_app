import 'package:flutter/material.dart';
import 'package:tea_diary_app/custom_colors/custom_colors.dart';

import '../../custom_widgets/custom_appbar.dart';

class BillGenerateScreen extends StatefulWidget {
  const BillGenerateScreen({super.key});

  @override
  State<BillGenerateScreen> createState() => _BillGenerateScreenState();
}

class _BillGenerateScreenState extends State<BillGenerateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          centerTitle: false,
          title: Text("Billing"),
        implyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primaryColor,
        onPressed: () {},
        child: Icon(Icons.save, color: CustomColors.whiteColor),
      ),
    );
  }
}
