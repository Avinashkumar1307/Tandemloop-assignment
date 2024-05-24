import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/crop_provider.dart';
import 'crop_list_screen.dart';
import '../widgets/crop_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final cropProvider = Provider.of<CropProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CropListScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Manage Your Crops',
                style: TextStyle(
                  fontSize: 26.0, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue, // Light blue text color
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Keep track of your crops by adding planting and estimated harvest dates. Use the form below to add a new crop to your list.',
                style: TextStyle(
                  fontSize: 18.0, // Increased font size
                  color: Colors.lightBlue, // Light blue text color
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height: 20), // Adding space between the content and form
              CropForm(),
            ],
          ),
        ),
      ),
    );
  }
}
