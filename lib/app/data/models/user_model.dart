class User {
  User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.role,
    this.profileImageUrl,
  });

  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String role;
  final DateTime createdAt;
  String? profileImageUrl;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json['email'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      profileImageUrl: json['profileImage'],
    );
  }
}
