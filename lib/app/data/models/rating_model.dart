import 'package:business_dir/app/data/models/user_model.dart';

class RatingModel {
  RatingModel({
    required this.id,
    required this.rating,
    required this.ratedBy,
    required this.createdAt,
    this.comment,
  });

  final String id;
  final num rating;
  final String? comment;
  final DateTime createdAt;
  final UserModel ratedBy;

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json["id"],
      rating: json['rating'],
      comment: json['comment'],
      ratedBy: UserModel.fromJson(json['user']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'user': ratedBy.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
