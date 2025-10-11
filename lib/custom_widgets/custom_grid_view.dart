

import 'package:flutter/material.dart';
import 'package:tea_diary_app/custom_colors/custom_colors.dart';
import 'package:tea_diary_app/screens/all_seller_item_screens/item_screen.dart';
import 'package:tea_diary_app/screens/all_seller_item_screens/seller_screen.dart';
import 'package:tea_diary_app/screens/all_seller_item_screens/sellerwise_item_screen.dart';
import 'package:tea_diary_app/screens/bill_generate_history_screens/bill_generate_screen.dart';
import 'package:tea_diary_app/screens/bill_generate_history_screens/bill_history_screen.dart';
import 'package:tea_diary_app/screens/new_order_screen/new_order_screen.dart';

import '../screens/dashboard_screen/dashboard_screen.dart';
import 'custom_appbar.dart';

class CustomGridView extends StatefulWidget {

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {

  List cardIconList = [
    Icons.people_alt_rounded,
    Icons.coffee_rounded,
    Icons.person_pin,
    Icons.assignment_rounded,
    Icons.monetization_on_rounded,
    Icons.history_outlined,
  ];
  List cardNameList = [
    "Seller",
    "Item",
    "Sellerwise Item",
    "New Order",
    "Generate Bill",
    "Bill History",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: GridView.builder(
        itemCount: cardNameList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              navigateToPage(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.whiteColor,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(cardIconList[index], size: 30, color: CustomColors.primaryColor,),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(cardNameList[index], style: TextStyle(fontWeight: FontWeight.w300))],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SellerScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SellerwiseItemScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewOrderScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BillGenerateScreen()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BillHistoryScreen()
          ),
        );
        break;
    }
  }
}
