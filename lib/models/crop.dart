class Crop {
  String name;
  DateTime plantingDate;
  DateTime estimatedHarvestDate;
  DateTime? actualHarvestDate;

  Crop({
    required this.name,
    required this.plantingDate,
    required this.estimatedHarvestDate,
    this.actualHarvestDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'plantingDate': plantingDate.toIso8601String(),
      'estimatedHarvestDate': estimatedHarvestDate.toIso8601String(),
      'actualHarvestDate': actualHarvestDate?.toIso8601String(),
    };
  }

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      name: json['name'],
      plantingDate: DateTime.parse(json['plantingDate']),
      estimatedHarvestDate: DateTime.parse(json['estimatedHarvestDate']),
      actualHarvestDate: json['actualHarvestDate'] != null
          ? DateTime.parse(json['actualHarvestDate'])
          : null,
    );
  }
}
