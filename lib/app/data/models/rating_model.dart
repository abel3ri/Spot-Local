import 'package:business_dir/app/data/models/user_model.dart';

class RatingModel {
  RatingModel({
    required this.id,
    required this.rating,
    required this.ratedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.helpful,
    this.comment,
  });

  final String id;
  final num rating;
  final String? comment;
  final int helpful;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User ratedBy;

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json["id"],
      rating: json['rating'],
      comment: json['comment'],
      ratedBy: User.fromJson(json['user']),
      helpful: json['helpful'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
