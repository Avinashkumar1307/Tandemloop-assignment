import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../widgets/crop_list_item.dart';
import 'home_screen.dart';
import '../models/crop.dart';

class CropListScreen extends StatefulWidget {
  @override
  _CropListScreenState createState() => _CropListScreenState();
}

class _CropListScreenState extends State<CropListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = "";
  bool _sortByPlantingDate = true;

  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context);

    // Filtering crops based on search query
    List<Crop> filteredCrops = cropProvider.crops
        .where((crop) =>
            crop.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    // Sorting crops based on selected criteria
    filteredCrops.sort((a, b) {
      if (_sortByPlantingDate) {
        return a.plantingDate.compareTo(b.plantingDate);
      } else {
        return a.estimatedHarvestDate.compareTo(b.estimatedHarvestDate);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Crop List'),
        backgroundColor: Colors.blue, // Customizing app bar color
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Crops',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sort by:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    DropdownButton<bool>(
                      value: _sortByPlantingDate,
                      items: [
                        DropdownMenuItem(
                          child: Text('Planting Date'),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text('Estimated Harvest Date'),
                          value: false,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _sortByPlantingDate = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCrops.length,
              itemBuilder: (ctx, i) => CropListItem(crop: filteredCrops[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Customizing FAB background color
      ),
    );
  }
}
