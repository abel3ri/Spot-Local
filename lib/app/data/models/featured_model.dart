import 'package:business_dir/app/data/models/business_model.dart';

class FeaturedModel {
  FeaturedModel({
    this.id,
    this.paymentAmount,
    this.status,
    this.businessId,
    this.business,
    this.expiresOn,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final double? paymentAmount;
  final String? status;
  final String? businessId;
  final BusinessModel? business;
  final DateTime? expiresOn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FeaturedModel.fromJson(Map<String, dynamic> json) {
    return FeaturedModel(
      id: json['id'],
      paymentAmount: (json['paymentAmount'] as num).toDouble(),
      status: json['status'],
      businessId: json['businessId'],
      business: json['business'] != null
          ? BusinessModel.fromJson(json['business'])
          : null,
      expiresOn: DateTime.parse(json['expiresOn']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
