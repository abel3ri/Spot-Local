import 'package:business_dir/app/data/models/user_model.dart';

class ReviewModel {
  ReviewModel({
    required this.id,
    required this.rating,
    required this.ratedBy,
    required this.helpful,
    required this.createdAt,
    required this.updatedAt,
    this.comment,
  });

  final String id;
  final num rating;
  final String? comment;
  final DateTime createdAt;
  final int helpful;
  final DateTime updatedAt;
  final UserModel ratedBy;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json["id"],
      rating: json['rating'],
      comment: json['comment'],
      ratedBy: UserModel.fromJson(json['user']),
      helpful: json['helpful'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'user': ratedBy.toJson(),
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}
