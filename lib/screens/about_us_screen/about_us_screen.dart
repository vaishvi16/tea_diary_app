import 'package:flutter/material.dart';

import '../../custom_colors/custom_colors.dart';
import '../../custom_widgets/custom_appbar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("About Us"),
        centerTitle: true,
        implyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=1050&q=80',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_cafe_rounded,
                            color: CustomColors.primaryColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Tea Diary App",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Welcome to the Tea Diary App — your digital companion for managing and tracking tea orders, sellers, and pricing efficiently.",
                        style: TextStyle(fontSize: 16, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "As a tea seller, this app helps you manage your daily operations with ease — from selecting items and setting prices to tracking orders and maintaining accurate records, all in one place.",
                        style: TextStyle(fontSize: 16, height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      Text(
                        "Our Purpose",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "To help tea businesses maintain transparency, accuracy, and efficiency in their ordering and management workflows.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.email, size: 20),
                          SizedBox(width: 8),
                          Text("support@teadiaryapp.com"),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 20),
                          SizedBox(width: 8),
                          Text("+91 9664656019"),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 20),
                          SizedBox(width: 8),
                          Expanded(child: Text("India")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
