import 'package:business_dir/app/data/models/business_model.dart';

class CityModel {
  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? stateId;
  final List<BusinessModel>? businesses;

  CityModel({
    this.id,
    this.name,
    this.businesses,
    this.createdAt,
    this.updatedAt,
    this.stateId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      businesses: json['businesses'] != null
          ? List<BusinessModel>.from(
              json['businesses'].map(
                (business) => BusinessModel.fromJson(business),
              ),
            )
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      stateId: json['stateId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      "businesses": businesses != null
          ? businesses!.map((business) => business.toJson())
          : null,
      'stateId': stateId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
