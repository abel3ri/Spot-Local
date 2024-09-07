import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/models/rating_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:latlong2/latlong.dart';

class Business {
  Business({
    required this.id,
    required this.name,
    required this.licenseNumber,
    required this.address,
    required this.latLng,
    required this.isVerified,
    required this.createdAt,
    required this.owner,
    required this.categories,
    this.email,
    this.description,
    this.logo,
    this.images,
    this.operationHours,
    this.phone,
    this.website,
    this.averageRating,
    this.ratings,
    this.socialMedia,
  });
  final String id;
  final String name;
  final String? logo;
  final String? description;
  final String licenseNumber;
  final String? operationHours;
  final String address;
  final List<String>? phone;
  final String? email;
  final String? website;
  final LatLng latLng;
  final bool isVerified;
  final List<String>? images;
  final DateTime createdAt;
  final num? averageRating;
  final User owner;
  final List<RatingModel>? ratings;
  final List<String>? socialMedia;
  final List<CategoryModel> categories;

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      licenseNumber: json['licenseNumber'],
      address: json['address'],
      latLng: LatLng(json['latLng'][0], json['latLng'][1]),
      isVerified: json['isVerified'],
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      email: json['email'],
      images: List<String>.from(json['images'] ?? []),
      logo: json['logo'],
      operationHours: json['operationHours'],
      phone: List<String>.from(json['phone'] ?? []),
      website: json['website'],
      averageRating: json['averageRating'],
      ratings: List<RatingModel>.from(json['ratings'].map(
            (rating) {
              return RatingModel.fromJson(rating);
            },
          ) ??
          []),
      owner: User.fromJson(json['user']),
      socialMedia: List<String>.from(
        json['socialMedia'] ?? [],
      ),
      categories: List<CategoryModel>.from(json['categories'].map(
            (category) {
              return CategoryModel.fromJson(category);
            },
          ) ??
          []),
    );
  }
}
