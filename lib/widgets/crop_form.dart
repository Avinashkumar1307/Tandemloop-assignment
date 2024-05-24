import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:provider/provider.dart';
import '../models/crop.dart';
import '../providers/crop_provider.dart';
import '../screens/crop_list_screen.dart';

class CropForm extends StatefulWidget {
  @override
  _CropFormState createState() => _CropFormState();
}

class _CropFormState extends State<CropForm> {
  final _cropNameController = TextEditingController();
  final _plantingDateController = TextEditingController();
  final _estimatedHarvestDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Border color
          width: 4.0, // Border width
        ),
        borderRadius: BorderRadius.circular(8.0), // Border radius
      ),
      child: Column(
        children: [
          TextField(
            controller: _cropNameController,
            decoration: InputDecoration(
              labelText: 'Crop Name',
              fillColor: Colors.white, // Text field background color
              filled: true, // Apply background color
            ),
          ),
          SizedBox(height: 12), // Adding some spacing between fields
          TextField(
            controller: _plantingDateController,
            decoration: InputDecoration(
              labelText: 'Planting Date (yyyy-MM-dd)',
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, _plantingDateController),
              ),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _estimatedHarvestDateController,
            decoration: InputDecoration(
              labelText: 'Estimated Harvest Date (yyyy-MM-dd)',
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () =>
                    _selectDate(context, _estimatedHarvestDateController),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Check if any field is empty
              if (_cropNameController.text.isEmpty ||
                  _plantingDateController.text.isEmpty ||
                  _estimatedHarvestDateController.text.isEmpty) {
                // Show a popup indicating that all fields are required
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('All fields are required'),
                    content: Text('Please fill in all fields to add a crop.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                // All fields are filled, proceed with adding the crop
                final crop = Crop(
                  name: _cropNameController.text,
                  plantingDate: DateTime.parse(_plantingDateController.text),
                  estimatedHarvestDate:
                      DateTime.parse(_estimatedHarvestDateController.text),
                );
                cropProvider.addCrop(crop);
                _cropNameController.clear();
                _plantingDateController.clear();
                _estimatedHarvestDateController.clear();

                // Navigate to CropListScreen after adding the crop
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CropListScreen(),
                ));

                // Show SnackBar
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Crop added successfully!'),
                  duration: Duration(seconds: 5),
                ));
              }
            },
            child: Text('Add Crop'),
            style: ElevatedButton.styleFrom(
              // primary: Colors.blue, // Button color
              textStyle: TextStyle(
                fontSize: 18, // Font size of the button text
                fontWeight: FontWeight.bold, // Bold font weight
              ),
              padding: EdgeInsets.symmetric(vertical: 16), // Vertical padding
              minimumSize: Size(
                  double.infinity, 50), // Set minimum button width and height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Button border radius
              ),
              elevation: 8, // Elevation of the button
            ),
          ),
        ],
      ),
    );
  }
}
