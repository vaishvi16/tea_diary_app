import 'package:flutter/material.dart';
import 'package:tea_diary_app/screens/about_us_screen/about_us_screen.dart';
import 'package:tea_diary_app/screens/all_seller_item_screens/item_screen.dart';
import 'package:tea_diary_app/screens/all_seller_item_screens/seller_screen.dart';
import 'package:tea_diary_app/screens/all_seller_item_screens/sellerwise_item_screen.dart';
import 'package:tea_diary_app/screens/bill_generate_history_screens/bill_generate_screen.dart';
import '../custom_colors/custom_colors.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.whiteColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: CustomColors.primaryColor,
            ),
            accountName: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/tea.jpg")),
            accountEmail: Text("Tea Diary",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w600),),
          ),
          Expanded(
            child: ListView(
              children: [
                showMenuOptions(
                  "Seller",
                  Icon(Icons.people_alt_rounded),
                  SellerScreen(),
                ),
                showMenuOptions(
                  "Item",
                  Icon(Icons.coffee_rounded),
                  ItemScreen(),
                ),
                showMenuOptions(
                  "Billing",
                  Icon(Icons.monetization_on_rounded),
                  BillGenerateScreen(),
                ),
                showMenuOptions(
                  "Sellerwise Item List",
                  Icon(Icons.person_pin),
                  SellerwiseItemScreen(),
                ),
                showMenuOptions(
                  "About Us",
                  Icon(Icons.info),
                  AboutUsScreen(),
                ),
                Divider(color: CustomColors.blackColor, thickness: 0,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12),
                  child: Text(
                    "Communicate",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Share",
                    style: TextStyle(color: CustomColors.blackColor),
                  ),
                  leading: Icon(Icons.share, color: CustomColors.blackColor),
                  onTap: () async {
                    //  SharedPreferences prefs = await SharedPreferences.getInstance();
                    //  await prefs.setBool("is_login", false);
                    //  await prefs.remove("user_id"); // Optional: Clear user ID
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showMenuOptions(String title, Icon icon, Widget screen) {
    return ListTile(
      title: Text(title, style: TextStyle(color: CustomColors.blackColor)),
      leading: icon,
      iconColor: CustomColors.blackColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
