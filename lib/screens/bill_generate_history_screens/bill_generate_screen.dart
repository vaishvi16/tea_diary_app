import 'package:flutter/material.dart';
import 'package:tea_diary_app/custom_colors/custom_colors.dart';

import '../../custom_widgets/custom_appbar.dart';

class BillGenerateScreen extends StatefulWidget {
  const BillGenerateScreen({super.key});

  @override
  State<BillGenerateScreen> createState() => _BillGenerateScreenState();
}

class _BillGenerateScreenState extends State<BillGenerateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          centerTitle: false,
          title: Text("Billing"),
        implyLeading: false,
      ),
      body: Scaffold(
        appBar: AppBar(
          title: Text('Invoice Details'),
          actions: [
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
            IconButton(icon: Icon(Icons.print), onPressed: () {}),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bill Header Section
              Text('Invoice #12345', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Invoice Date: Oct 14, 2025'),
                  Text('Due Date: Oct 28, 2025'),
                ],
              ),
              Divider(),

              // Sender and Receiver Details
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Your Company Name'),
                        Text('123 Business Rd'),
                        Text('City, State, Zip'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Bill To:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Client Name'),
                        Text('456 Client St'),
                        Text('Client City, State, Zip'),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),

              // Line Items Section (example with a few items)
              Text('Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              // In a real app, this would likely be a ListView.builder
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product A'),
                      Text('2 x \$50.00'),
                      Text('\$100.00'),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service B'),
                      Text('1 x \$150.00'),
                      Text('\$150.00'),
                    ],
                  ),
                ),
              ),
              Divider(),

              // Summary Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal:'),
                  Text('\$250.00'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax (8%):'),
                  Text('\$20.00'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grand Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('\$270.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
              Divider(),

              // Footer/Notes
              Text('Payment Terms: Net 15 days'),
              Text('Thank you for your business!'),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primaryColor,
        onPressed: () {},
        child: Icon(Icons.save, color: CustomColors.whiteColor),
      ),
    );
  }
}
