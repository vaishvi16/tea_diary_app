import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tea_diary_app/custom_widgets/custom_appbar.dart';

import '../../custom_colors/custom_colors.dart';
import '../../custom_widgets/custom_textfield.dart';

class EditItemScreen extends StatefulWidget {
  String id;
  String item_name;
  String item_price;

  EditItemScreen({
    required this.id,
    required this.item_name,
    required this.item_price,
  });

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.item_name;
    priceController.text = widget.item_price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        implyLeading: false,
        title: Text(
          "Edit Items",
          style: TextStyle(color: CustomColors.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          SizedBox(
                            width: 70,
                            child: Text("Name", style: TextStyle(fontSize: 16)),
                          ),
                          Text(" : "),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              hintText: 'Enter item name',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter item name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              "Price",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(" : "),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              hintText: 'Enter item price',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter price';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: CustomColors.primaryColor,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String nameValue = nameController.text.toString();
                      String priceValue = priceController.text.toString();

                      await _updateItem(nameValue, priceValue, widget.id);
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: CustomColors.whiteColor),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: CustomColors.primaryColor,
                  ),
                  onPressed: () async {
                    await _deleteItem(widget.id);
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(color: CustomColors.whiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateItem(String name, String price, id) async {
    var url = await Uri.parse(
      "https://prakrutitech.xyz/vaishvi/update_item.php",
    );
    var response = await http.post(
      url,
      body: {"id": id, "item_name": name, "item_price": price},
    );
    print("Item updated");

    if (response.statusCode == 200) {
      print("update item: ${response.body}");
    } else {
      print("Failed to update item. Status: ${response.statusCode}");
    }
  }

  Future<void> _deleteItem(id) async {
    var url = Uri.parse("https://prakrutitech.xyz/vaishvi/delete_item.php");
    await http.post(url, body: {"id": id});
  }
}
