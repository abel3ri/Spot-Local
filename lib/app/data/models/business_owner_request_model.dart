import 'package:business_dir/app/data/models/business_model.dart';
import 'package:business_dir/app/data/models/user_model.dart';

class BusinessOwnerRequestModel {
  final String? id;
  final String? status;
  final String? userId;
  final String? businessId;
  final String? processedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;
  final UserModel? processedByUser;
  final BusinessModel? business;

  const BusinessOwnerRequestModel({
    required this.id,
    required this.status,
    required this.userId,
    required this.businessId,
    this.processedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.processedByUser,
    required this.business,
  });

  factory BusinessOwnerRequestModel.fromJson(Map<String, dynamic> json) {
    return BusinessOwnerRequestModel(
      id: json['id'],
      status: json['status'],
      userId: json['userId'],
      businessId: json['businessId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      business: json['business'] != null
          ? BusinessModel.fromJson(json['business'])
          : null,
      processedBy: json['processedBy'],
      processedByUser: json['processedByUser'] != null
          ? UserModel.fromJson(json['processedByUser'])
          : null,
    );
  }
}
