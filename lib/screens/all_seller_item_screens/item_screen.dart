import 'package:flutter/material.dart';

import '../../custom_colors/custom_colors.dart';
import '../../custom_widgets/custom_appbar.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: false,
        centerTitle: false,
        title: Text("Item List"),
        actions: [Icon(Icons.add, color: CustomColors.whiteColor)],
      ),
    );
  }
}
