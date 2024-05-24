import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import 'crop_list_screen.dart';
import '../widgets/crop_form.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Farm Buddy',
          style: TextStyle(
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Bold font weight
            color: Colors.white, // Text color
          ),
        ),
        backgroundColor: Colors.blue, // Background color of the app bar
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CropListScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Manage Your Crops',
                style: TextStyle(
                  fontSize: 26.0, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue, // Light blue text color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Keep track of your crops by adding planting and estimated harvest dates. Use the form below to add a new crop to your list.',
                style: TextStyle(
                  fontSize: 18.0, // Increased font size
                  color: Colors.lightBlue, // Light blue text color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Adding space between the content and form
              CropForm(),
            ],
          ),
        ),
      ),
    );
  }
}
