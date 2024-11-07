import 'package:business_dir/app/data/models/business_model.dart';

class FavoriteModel {
  FavoriteModel({
    this.id,
    this.businessId,
    this.userId,
    this.business,
    this.createdAt,
    this.updatedAt,
  });
  final String? id;
  final String? userId;
  final String? businessId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BusinessModel? business;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      userId: json['userId'],
      businessId: json['businessId'],
      business: json['business'] != null
          ? BusinessModel.fromJson(json['business'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
