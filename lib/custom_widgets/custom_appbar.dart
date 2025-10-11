import 'package:flutter/material.dart';

import '../custom_colors/custom_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  var title;
  final List<Widget>? actions;
  bool centerTitle;
  bool implyLeading;

  CustomAppBar({this.title, required this.centerTitle, this.actions, required this.implyLeading});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.implyLeading,
      title: widget.title,
      titleTextStyle: TextStyle(color: CustomColors.whiteColor,fontSize: 23),
      backgroundColor: CustomColors.primaryColor,
      centerTitle: widget.centerTitle,
      actions: widget.actions,
      iconTheme: IconThemeData(color: CustomColors.whiteColor,size: 30),
    );
  }
}
