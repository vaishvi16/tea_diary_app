import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tea_diary_app/custom_colors/custom_colors.dart';

import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_dropdown.dart';

class BillHistoryScreen extends StatefulWidget {
  const BillHistoryScreen({super.key});

  @override
  State<BillHistoryScreen> createState() => _BillHistoryScreenState();
}

class _BillHistoryScreenState extends State<BillHistoryScreen> {
  List<dynamic> sellerItems = [];
  List<Map<String, String>> sellerList = [];
  Future<Map<String, dynamic>>? ordersFuture;

  String? selectedSeller;
  String? selectedSellerId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSellers().then((_) {
      setState(() {
        isLoading = false; // initialize with current date
      });
    });
  }

  Future<List<dynamic>> _fetchSellerwiseItems(String sellerId) async {
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: CustomAppBar(
              centerTitle: false,
              title: Text("Bill History"),
              implyLeading: false,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 70,
                        child: Text("Name", style: TextStyle(fontSize: 16)),
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
                              sellerItems = [];
                              ordersFuture = _fetchOrders();
                            });

                            var items = await _fetchSellerwiseItems(
                              selectedSellerId!,
                            );
                            setState(() {
                              sellerItems = items;
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
                ),
                Expanded(
                  child: FutureBuilder(
                    future: ordersFuture,
                    builder:
                        (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!['orders'].isEmpty) {
                            return Center(child: Text('No orders found'));
                          }

                          final orders = snapshot.data!['orders'];

                          return ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(orders[index]["order_date"]),
                                  trailing: Text("₹ ${orders[index]["total_amount"
                                    ]}",style: TextStyle(
                                    fontSize: 21,color: CustomColors.primaryLightColor
                                  ),),
                                ),
                              );
                            },
                          );
                        },
                  ),
                ),
              ],
            ),
          );
  }

  Future<Map<String, dynamic>> _fetchOrders() async {
    var url = Uri.parse(
      "https://prakrutitech.xyz/vaishvi/t_get_order.php?seller_id=$selectedSellerId",
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error occurred ${response.statusCode}");
    }
  }
}
