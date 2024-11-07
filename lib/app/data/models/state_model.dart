import 'package:business_dir/app/data/models/city_model.dart';

class StateModel {
  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CityModel>? cities;

  StateModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.cities,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        id: json["id"],
        name: json["name"],
        cities: json['cities'] != null
            ? List<CityModel>.from(
                json['cities'].map((city) => CityModel.fromJson(city)),
              )
            : null,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cities": cities != null ? cities!.map((city) => city.toJson()) : null,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
