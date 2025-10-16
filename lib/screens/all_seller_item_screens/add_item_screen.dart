import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tea_diary_app/custom_colors/custom_colors.dart';
import 'package:tea_diary_app/custom_widgets/custom_appbar.dart';
import 'package:tea_diary_app/custom_widgets/custom_textfield.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String nameValue = "";
  String priceValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        implyLeading: false,
        title: Text(
          "Add New Item",
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: CustomColors.primaryColor,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  nameValue = nameController.text.toString();
                  priceValue = priceController.text.toString();

                  await _insertItem(nameValue, priceValue);
                   Navigator.pop(context, true);
                }
              },
              child: Text(
                "Add Item",
                style: TextStyle(color: CustomColors.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _insertItem(name, price) async {
    var url = await Uri.parse(
      "https://prakrutitech.xyz/vaishvi/insert_item.php",
    );

    var resp = await http.post(
      url,
      body: {"item_name": name, "item_price": price},
    );

    print("Item Inserted $name $price");

    if (resp.statusCode == 200) {
      print("Added seller: ${resp.body}");
    } else {
      print("Failed to insert seller: ${resp.body}");
    }
  }
}
