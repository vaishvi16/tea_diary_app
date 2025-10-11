import 'package:flutter/material.dart';

import '../../custom_colors/custom_colors.dart';
import '../../custom_widgets/custom_appbar.dart';

class SellerwiseItemScreen extends StatefulWidget {
  const SellerwiseItemScreen({super.key});

  @override
  State<SellerwiseItemScreen> createState() => _SellerwiseItemScreenState();
}

class _SellerwiseItemScreenState extends State<SellerwiseItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        implyLeading: false,
        title: Text("Manage Menu Items"),
      ),
    );
  }
}
