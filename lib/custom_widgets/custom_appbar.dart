import 'package:flutter/material.dart';

import '../custom_colors/custom_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  var title;
  final List<Widget>? actions;
  bool centerTitle;

  CustomAppBar({this.title, required this.centerTitle, this.actions});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      backgroundColor: CustomColors.primaryColor,
      centerTitle: widget.centerTitle,
      actions: widget.actions,
      iconTheme: IconThemeData(color: CustomColors.whiteColor),
    );
  }
}
