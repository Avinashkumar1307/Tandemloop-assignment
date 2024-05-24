import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/crop.dart';
import '../providers/crop_provider.dart';

class CropListItem extends StatelessWidget {
  final Crop crop;

  CropListItem({required this.crop});

  @override
  Widget build(BuildContext context) {
    final cropProvider = Provider.of<CropProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue, // Light blue background color
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Planting Date: ${crop.plantingDate.toLocal().toIso8601String().split('T')[0]}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Estimated Harvest: ${crop.estimatedHarvestDate.toLocal().toIso8601String().split('T')[0]}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: crop.actualHarvestDate == null
                      ? ElevatedButton(
                          onPressed: () {
                            cropProvider.markAsHarvested(crop, DateTime.now());
                          },
                          child: Text('Mark as Harvested'),
                        )
                      : Text(
                          'Harvested on ${crop.actualHarvestDate!.toLocal().toIso8601String().split('T')[0]}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
