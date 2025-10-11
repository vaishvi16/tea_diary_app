import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tea_diary_app/custom_colors/custom_colors.dart';
import 'package:tea_diary_app/custom_widgets/custom_appbar.dart';
import 'package:tea_diary_app/custom_widgets/custom_textfield.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String nameValue = "";
  String mobValue = "";
  String addValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: false,
        centerTitle: false,
        title: Text("Seller List"),
        actions: [
          IconButton(
            onPressed: () {
              openPopUpMenu();
            },
            icon: Icon(Icons.add, color: CustomColors.whiteColor),
          ),
        ],
      ),
    );
  }

  void openPopUpMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          title: Container(
            height: 40,
            color: CustomColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add New Seller",
                style: TextStyle(color: CustomColors.whiteColor),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  hintText: "Name",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomTextField(
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  hintText: "Mobile",
                  maxLength: 10,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomTextField(
                  keyboardType: TextInputType.streetAddress,
                  controller: addressController,
                  hintText: "Address",
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    CustomColors.primaryColor,
                  ),
                ),
                onPressed: () {
                  nameValue = nameController.text.toString();
                  mobValue = mobileController.text.toString();
                  addValue = addressController.text.toString();
                  _addSeller(nameValue, mobValue, addValue);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: CustomColors.whiteColor,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addSeller(var name, var mobile, var address) async {
    var url = await Uri.parse(
      "http://192.168.29.140/tea_diary/insert_seller.php",
    );

    final response = await http.post(
      url,
      body: {"seller_name": name, "contact": mobile, "address": address},
    );

    print("Added seller");

    if (response.statusCode == 200) {
      print("Added seller: ${response.body}");
    } else {
      print("Failed to add seller. Status: ${response.statusCode}");
    }
  }
}
