import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/crop.dart';
import 'dart:convert';

class CropProvider with ChangeNotifier {
  List<Crop> _crops = [];

  List<Crop> get crops => _crops;

  void addCrop(Crop crop) {
    _crops.add(crop);
    _saveToPrefs();
    notifyListeners();
  }

  void markAsHarvested(Crop crop, DateTime actualHarvestDate) {
    crop.actualHarvestDate = actualHarvestDate;
    _saveToPrefs();
    notifyListeners();
  }

  List<Crop> get harvestedCrops =>
      _crops.where((crop) => crop.actualHarvestDate != null).toList();

  void _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'crops', jsonEncode(_crops.map((c) => c.toJson()).toList()));
  }

  void loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cropsString = prefs.getString('crops');
    if (cropsString != null) {
      _crops = (jsonDecode(cropsString) as List)
          .map((data) => Crop.fromJson(data))
          .toList();
      notifyListeners();
    }
  }
}
