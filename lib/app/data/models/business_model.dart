import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/models/review_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:latlong2/latlong.dart';

class BusinessModel {
  BusinessModel({
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
    this.totalRatings,
    this.ratings,
    this.socialMedia,
  });
  final String? id;
  final String? name;
  final String? logo;
  final String? description;
  final String? licenseNumber;
  final String? operationHours;
  final String? address;
  final List<String>? phone;
  final String? email;
  final String? website;
  final LatLng? latLng;
  final bool? isVerified;
  final List<String>? images;
  final DateTime? createdAt;
  final num? averageRating;
  final UserModel? owner;
  final List<ReviewModel>? ratings;
  final List<String>? socialMedia;
  final List<CategoryModel>? categories;
  final num? totalRatings;

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
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
      totalRatings: json['totalRatings'],
      ratings: List<ReviewModel>.from(json['ratings'].map(
            (rating) {
              return ReviewModel.fromJson(rating);
            },
          ) ??
          []),
      owner: UserModel.fromJson(json['user']),
      socialMedia: List<String>.from(
        json['socialMedia'] ?? [],
      ),
      categories: List<CategoryModel>.from(
        json['categories'].map(
              (category) {
                return CategoryModel.fromJson(category);
              },
            ) ??
            [],
      ),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'licenseNumber': licenseNumber,
      'address': address,
      'latLng': latLng != null ? [latLng!.latitude, latLng!.longitude] : null,
      'isVerified': isVerified ?? false,
      'createdAt': createdAt?.toIso8601String(),
      'description': description ?? '',
      'email': email ?? '',
      'images': images ?? [],
      'logo': logo ?? '',
      'operationHours': operationHours ?? '',
      'phone': phone ?? [],
      'website': website ?? '',
      'averageRating': averageRating ?? 0,
      'totalRatings': totalRatings ?? 0,
      'ratings': ratings?.map((rating) => rating.toJson()).toList() ?? [],
      'user': owner?.toJson() ?? null,
      'socialMedia': socialMedia ?? [],
      'categories':
          categories?.map((category) => category.toJson()).toList() ?? [],
    };
  }
}
