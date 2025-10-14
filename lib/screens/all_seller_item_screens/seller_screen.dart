import 'dart:convert';

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
  var id;

  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _fetchSeller();
  }

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
              _isEdit = false;
              nameController.text = "";
              mobileController.text = "";
              addressController.text = "";

              openPopUpMenu();
            },
            icon: Icon(Icons.add, color: CustomColors.whiteColor),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchSeller(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            print("Network not found");
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _isEdit = true;
                    nameController.text = snapshot.data[index]["seller_name"];
                    mobileController.text = snapshot.data[index]["contact"];
                    addressController.text = snapshot.data[index]["address"];
                    id = snapshot.data[index]["id"];

                    openPopUpMenu();
                  },
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.person_rounded,
                            color: CustomColors.primaryColor,
                          ),
                          SizedBox(width: 3),
                          Text(snapshot.data[index]["seller_name"]),
                        ],
                      ),
                      trailing: Wrap(
                        children: [
                          Icon(
                            Icons.call_outlined,
                            color: CustomColors.primaryColor,
                          ),
                          SizedBox(width: 3),
                          Text(
                            snapshot.data[index]["contact"],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(CustomColors.primaryColor),
            ),
          );
        },
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
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: CustomColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _isEdit ? "Seller Details" : "Add New Seller",
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
          actions: _isEdit
              ? [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: CustomColors.primaryColor,
                          ),
                          onPressed: () {
                            nameValue = nameController.text.toString();
                            mobValue = mobileController.text.toString();
                            addValue = addressController.text.toString();
                            _updateSeller(nameValue, mobValue, addValue, id);

                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: CustomColors.whiteColor,
                              fontSize: 21,
                            ),
                          ),
                        ),
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: CustomColors.primaryColor,
                          ),
                          onPressed: () {
                            _deleteSeller(id);
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: CustomColors.whiteColor,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              : [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: CustomColors.primaryColor,
                      ),
                      onPressed: () {
                        nameValue = nameController.text.toString();
                        mobValue = mobileController.text.toString();
                        addValue = addressController.text.toString();
                        _addSeller(nameValue, mobValue, addValue);

                        setState(() {
                          _isEdit = false;

                          nameController.clear();
                          mobileController.clear();
                          addressController.clear();
                        });

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
      "https://prakrutitech.xyz/vaishvi/insert_seller.php",
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
    setState(() {});
  }

  Future<void> _fetchSeller() async {
    var url = await Uri.parse(
      "https://prakrutitech.xyz/vaishvi/view_seller.php",
    );
    var resp = await http.get(url);
    return jsonDecode(resp.body);
  }

  Future<void> _updateSeller(
    String name,
    String contact,
    String add,
    id,
  ) async {
    var url = await Uri.parse(
      "https://prakrutitech.xyz/vaishvi/update_seller.php",
    );

    var response = await http.post(
      url,
      body: {"id": id, "seller_name": name, "contact": contact, "address": add},
    );
    print("Seller updated");

    if (response.statusCode == 200) {
      print("update seller: ${response.body}");
    } else {
      print("Failed to update seller. Status: ${response.statusCode}");
    }
    setState(() {});
  }

  _deleteSeller(id) {
    var url = Uri.parse("https://prakrutitech.xyz/vaishvi/delete_seller.php");
    http.post(url, body: {"id": id});
    setState(() {});
  }
}
