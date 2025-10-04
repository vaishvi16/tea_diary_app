import 'package:flutter/material.dart';
import 'package:tea_diary_app/dashboard_screen/dashboard_screen.dart';

import '../custom_colors/custom_colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.primaryColor,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                ),
              ),
              Center(child: Image.asset("assets/logo/blood_logo.png")),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                showMenuOptions(
                  "Profile",
                  Icon(Icons.person_rounded),
                  DashboardScreen(),
                ),
                showMenuOptions(
                  "Requests",
                  Icon(Icons.bloodtype_outlined),
                  DashboardScreen(),
                ),
                showMenuOptions(
                  "Guidelines to donate blood",
                  Icon(Icons.note_outlined),
                  DashboardScreen(),
                ),
                showMenuOptions(
                  "Donation List",
                  Icon(Icons.history_outlined),
                  DashboardScreen(),
                ),
                showMenuOptions(
                  "About Us",
                  Icon(Icons.info),
                  DashboardScreen(),
                ),
              ],
            ),
          ),
          Divider(color: CustomColors.whiteColor),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                "Logout",
                style: TextStyle(color: CustomColors.whiteColor),
              ),
              leading: Icon(Icons.logout, color: CustomColors.whiteColor),
              onTap: () async {
                //  SharedPreferences prefs = await SharedPreferences.getInstance();
                //  await prefs.setBool("is_login", false);
                //  await prefs.remove("user_id"); // Optional: Clear user ID
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  showMenuOptions(String title, Icon icon, Widget screen) {
    return ListTile(
      title: Text(title, style: TextStyle(color: CustomColors.whiteColor)),
      leading: icon,
      iconColor: CustomColors.whiteColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
