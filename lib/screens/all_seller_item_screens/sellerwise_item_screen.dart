import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../custom_colors/custom_colors.dart';
import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_dropdown.dart';

class SellerwiseItemScreen extends StatefulWidget {
  const SellerwiseItemScreen({super.key});

  @override
  State<SellerwiseItemScreen> createState() => _SellerwiseItemScreenState();
}

class _SellerwiseItemScreenState extends State<SellerwiseItemScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedSeller;
  String? selectedSellerId;
  List<Map<String, String>> sellerList = [];

  List<dynamic> itemList = [];
  List<bool> selectedItems = [];

  bool isLoading = true;
  bool showItemError = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await fetchSellers();
    await fetchItems();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchSellers() async {
    var url = Uri.parse("https://prakrutitech.xyz/vaishvi/view_seller.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      sellerList = data
          .map(
            (list) => {
              'id': list['id'].toString(),
              'name': list['seller_name'].toString(),
            },
          )
          .toList();
    }
  }

  Future<void> fetchItems() async {
    var url = Uri.parse("https://prakrutitech.xyz/vaishvi/view_item.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      itemList = jsonDecode(response.body);
      selectedItems = List.filled(itemList.length, false);
    }
  }

  Future<void> submitSellerWiseItems() async {
    for (int i = 0; i < itemList.length; i++) {
      if (selectedItems[i]) {
        String itemName = itemList[i]['item_name'];
        String itemPrice = itemList[i]['item_price'];

        var url = Uri.parse(
          "https://prakrutitech.xyz/vaishvi/insert_item_seller_wise.php",
        );
        var response = await http.post(
          url,
          body: {
            'seller_id': selectedSellerId ?? '',
            'item_name': itemName,
            'item_price': itemPrice,
          },
        );

        if (response.statusCode != 200) {
          print("Failed to save item: $itemName");
        }
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Items saved successfully')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        implyLeading: false,
        title: Text("Manage Menu Items"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Card(
                  color: Colors.white54,
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 70,
                                child: Text(
                                  "Name",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomDropdown<String>(
                                  hintText: "Seller Name",
                                  labelText: "Select Seller Name",
                                  value: selectedSeller,
                                  items: sellerList
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e['name'],
                                          child: Text(e['name'] ?? ''),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectedSeller = val;
                                      selectedSellerId = sellerList.firstWhere(
                                        (element) => element['name'] == val,
                                      )['id'];
                                    });
                                  },
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please select a seller name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: CheckboxListTile(
                          title: Row(
                            children: [
                              Icon(
                                Icons.library_books_outlined,
                                color: CustomColors.primaryColor,
                              ),
                              SizedBox(width: 8),
                              Text("${itemList[index]['item_name']}"),
                              SizedBox(width: 20),
                              Text(
                                "₹${itemList[index]['item_price']}",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          value: selectedItems[index],
                          onChanged: (val) {
                            setState(() {
                              selectedItems[index] = val ?? false;
                              showItemError = false;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                if (showItemError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Please select at least one item.",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        bool anyItemSelected = selectedItems.contains(true);
                        if (!anyItemSelected) {
                          setState(() {
                            showItemError = true;
                          });
                          return;
                        }
                        submitSellerWiseItems();
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: CustomColors.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
