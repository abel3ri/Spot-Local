import 'package:business_dir/app/data/models/category_model.dart';
import 'package:business_dir/app/data/models/city_model.dart';
import 'package:business_dir/app/data/models/review_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';
import 'package:get/get.dart';
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
    this.businessLicense,
    this.email,
    this.description,
    this.logo,
    this.images,
    this.operationHours,
    this.phone,
    this.website,
    this.averageRating,
    this.totalRatings,
    this.reviews,
    this.socialMedia,
    this.isFeatured = false,
    this.isSuspended = false,
    this.city,
    bool? isFavorited,
  }) : isFavorited = RxBool(isFavorited ?? false);
  final String? id;
  final String? name;
  final Map<String, dynamic>? logo;
  final Map<String, dynamic>? businessLicense;
  final String? description;
  final String? licenseNumber;
  final String? operationHours;
  final String? address;
  final List<String>? phone;
  final String? email;
  final String? website;
  final LatLng? latLng;
  final bool? isVerified;
  final List<Map<String, dynamic>?>? images;
  final DateTime? createdAt;
  final num? averageRating;
  final UserModel? owner;
  final List<ReviewModel>? reviews;
  final List<String>? socialMedia;
  final List<CategoryModel>? categories;
  final num? totalRatings;
  bool isFeatured;
  final bool isSuspended;
  final RxBool isFavorited;
  final CityModel? city;

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'],
      name: json['name'],
      licenseNumber: json['licenseNumber'],
      address: json['address'],
      latLng: LatLng(json['latLng'][0], json['latLng'][1]),
      isVerified: json['isVerified'],
      description: json['description'],
      email: json['email'],
      images: json['images'] != null
          ? List<Map<String, dynamic>>.from(json['images'] ?? [])
          : null,
      logo: json['logo'],
      businessLicense: json['businessLicense'],
      operationHours: json['operationHours'],
      phone: json['phone'] != null ? List<String>.from(json['phone']) : null,
      website: json['website'],
      averageRating: json['averageRating'],
      totalRatings: json['totalRatings'],
      reviews: json['ratings'] != null
          ? List<ReviewModel>.from(
              json['ratings'].map((review) => ReviewModel.fromJson(review)) ??
                  [],
            )
          : null,
      owner: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      socialMedia: json['socialMedia'] != null
          ? List<String>.from(
              json['socialMedia'] ?? [],
            )
          : null,
      categories: json['categories'] != null
          ? List<CategoryModel>.from(
              json['categories']
                      .map((category) => CategoryModel.fromJson(category)) ??
                  [],
            )
          : null,
      isFeatured: json['isFeatured'],
      isSuspended: json['isSuspended'],
      isFavorited: json['favorites'] != null && json['favorites'].isNotEmpty,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      createdAt: DateTime.parse(json['createdAt']),
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
      'logo': logo,
      'operationHours': operationHours ?? '',
      'phone': phone ?? [],
      'website': website ?? '',
      'averageRating': averageRating ?? 0,
      'totalRatings': totalRatings ?? 0,
      'ratings': reviews?.map((rating) => rating.toJson()).toList() ?? [],
      'user': owner?.toJson(),
      'socialMedia': socialMedia ?? [],
      "isFeatured": isFeatured,
      "isSuspended": isSuspended,
      'categories':
          categories?.map((category) => category.toJson()).toList() ?? [],
    };
  }
}
