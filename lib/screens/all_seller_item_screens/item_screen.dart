import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../custom_colors/custom_colors.dart';
import '../../custom_widgets/custom_appbar.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  var id;
  String name = "", price = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: false,
        centerTitle: false,
        title: Text("Item List"),
        actions: [
          IconButton(
            onPressed: () async{
             await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemScreen()),
              );
              setState(() {
                _fetchItems();
              });
            },
            icon: Icon(Icons.add, color: CustomColors.whiteColor),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchItems(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            print("Network not found");
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async{
                    id = snapshot.data[index]["id"];
                    name = snapshot.data[index]["item_name"];
                    price = snapshot.data[index]["item_price"];

                   await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditItemScreen(id: '$id', item_name: name, item_price: price,),
                      ),
                    );
                   setState(() {
                     _fetchItems();
                   });
                  },
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.library_books_outlined,
                            color: CustomColors.primaryColor,
                          ),
                          SizedBox(width: 3),
                          Text(snapshot.data[index]["item_name"]),
                        ],
                      ),
                      trailing: Text(
                        snapshot.data[index]["item_price"],
                        style: TextStyle(fontSize: 16),
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

  Future<void> _fetchItems() async {
    var url = Uri.parse("https://prakrutitech.xyz/vaishvi/view_item.php");

    var response = await http.get(url);

    return jsonDecode(response.body);
  }
}
