import 'package:business_dir/app/data/models/business_model.dart';

class CityModel {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String stateId;
  List<BusinessModel> businesses;

  CityModel({
    required this.id,
    required this.name,
    required this.businesses,
    required this.createdAt,
    required this.updatedAt,
    required this.stateId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      businesses: List<BusinessModel>.from(
        json['businesses'].map((business) => BusinessModel.fromJson(business)),
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      stateId: json['stateId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      "businesses": businesses.map((business) => business.toJson()),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'stateId': stateId,
    };
  }
}
