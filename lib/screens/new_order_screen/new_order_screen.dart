import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tea_diary_app/custom_widgets/custom_textfield.dart';

import '../../custom_colors/custom_colors.dart';
import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_dropdown.dart';

class NewOrderScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? selectedItems;

  NewOrderScreen({this.selectedItems});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedSeller;
  String? selectedSellerId;
  List<Map<String, String>> sellerList = [];

  DateTime selectedDate = DateTime.now();
  bool isLoading = true;

  TextEditingController dateController = TextEditingController();

  List<int> value = [];
  List<num> total = [];

  List<dynamic> sellerItems = [];

  @override
  void initState() {
    super.initState();
    fetchSellers().then((_) {
      setState(() {
        isLoading = false;
        dateController.text = formatDate(
          selectedDate,
        ); // initialize with current date
      });
    });
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
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

  Future<List<dynamic>> _fetchSellerwiseItems(String sellerId) async {
    print("New order screen seller id fetched $sellerId");
    var url = Uri.parse(
      "https://prakrutitech.xyz/vaishvi/view_item_seller_wise.php",
    );
    var response = await http.post(url, body: {'seller_id': sellerId});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load seller items');
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = formatDate(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: CustomAppBar(
              centerTitle: false,
              implyLeading: false,
              title: Text(
                "New Order",
                style: TextStyle(color: CustomColors.whiteColor),
              ),
            ),
            body: Column(
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
                                  onChanged: (val) async {
                                    setState(() {
                                      selectedSeller = val;
                                      selectedSellerId = sellerList.firstWhere(
                                            (element) => element['name'] == val,
                                      )['id'];

                                      sellerItems = widget.selectedItems ?? [];
                                      value = List<int>.filled(sellerItems.length, 1);
                                      total = List<num>.generate(
                                        sellerItems.length,
                                            (index) => num.parse(
                                          sellerItems[index]['item_price'].toString(),
                                        ),
                                      );
                                      isLoading = false;
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 50,
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _selectDate,
                        child: AbsorbPointer(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: CustomTextField(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 12,
                              ),
                              keyboardType: TextInputType.datetime,
                              hintText: "Select Date",
                              labelText: "Date",
                              controller: dateController,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                selectedSellerId != null && selectedSellerId!.isNotEmpty
                    ? sellerItems.isNotEmpty
                          ? Expanded(
                              child: Card(
                                color: Colors.white54,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        "MENU",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 20,
                                          ),
                                          child: Text(
                                            "Item",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 20,
                                          ),
                                          child: Text(
                                            "Quantity",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 20,
                                          ),
                                          child: Text(
                                            "Price",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: sellerItems.length,
                                        itemBuilder: (context, index) {
                                          final item = sellerItems[index]['item_name'];
                                          final price = num.parse(sellerItems[index]['item_price'].toString());

                                          final quantity = value[index];
                                          final itemTotal = price * quantity;

                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(item),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      if (value[index] > 1) {
                                                        setState(() {
                                                          value[index]--;
                                                        });
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                    ),
                                                  ),
                                                  Text("$quantity"),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        value[index]++;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                itemTotal.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20.0,
                                          ),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 20.0,
                                          ),
                                          child: Text(
                                            "₹ ${_calculateGrandTotal().toString()}",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 16,
                                        ),
                                      ),
                                      onPressed: () {
                                        var grandTotal = _calculateGrandTotal()
                                            .toString();
                                        var date = dateController.text
                                            .toString();
                                        placeOrder(
                                          grandTotal,
                                          selectedSellerId!,
                                          date,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Place Order",
                                        style: TextStyle(
                                          color: CustomColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator())
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 28.0),
                          child: Text(
                            "Please select your name to see the details",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
              ],
            ),
          );
  }

  num _calculateGrandTotal() {
    num grandTotal = 0;
    for (int i = 0; i < sellerItems.length; i++) {
      final itemPrice = num.parse(sellerItems[i]["item_price"]);
      grandTotal += itemPrice * value[i];
    }
    return grandTotal;
  }

  Future<void> placeOrder(String total, String selectedSellerId, String orderDate) async {
    final url = Uri.parse("https://prakrutitech.xyz/vaishvi/t_place_order.php");

    List<Map<String, dynamic>> items = [];

    for (int i = 0; i < sellerItems.length; i++) {
      final itemIdStr = sellerItems[i]["item_id"];
      final priceStr = sellerItems[i]["item_price"];

      if (itemIdStr == null || priceStr == null) {
        print("Skipping item at index $i due to missing data.");
        continue;
      }

      items.add({
        "item_id": int.parse(itemIdStr),
        "quantity": value[i],
        "price": num.parse(priceStr),
      });
    }

    final Map<String, dynamic> requestBody = {
      "seller_id": int.parse(selectedSellerId),
      "total_amount": num.parse(total),
      "items": items,
    };

    print("Seller ID: $selectedSellerId");
    print("Total: $total");
    print("Items: $items");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      print("Placed Order");

      if (response.statusCode == 200) {
        print("Placed order: ${response.body}");
      } else {
        print("Failed to place order. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error placing order: $e");
    }

    setState(() {});
  }
}
