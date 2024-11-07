class UserModel {
  UserModel({
    this.id,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.tin,
    this.profileImage,
    this.isSuspended,
  });

  final String? id;
  final String? email;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? tin;
  final bool? isSuspended;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? profileImage;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json['email'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      profileImage: json['profileImage'],
      tin: json['tin'],
      isSuspended: json['isSuspended'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'createdAt':
          createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'profileImage': profileImage,
    };
  }
}
