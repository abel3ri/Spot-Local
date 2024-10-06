class BusinessPerformanceModel {
  BusinessPerformanceModel({
    required this.averageRating,
    required this.totalReviews,
  });
  final num totalReviews;
  final num averageRating;

  factory BusinessPerformanceModel.fromJson(Map<String, dynamic> json) {
    return BusinessPerformanceModel(
      averageRating: json['averageRating'] ?? 0,
      totalReviews: json['totalRatings'] ?? 0,
    );
  }
}
