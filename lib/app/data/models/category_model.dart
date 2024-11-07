class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.createdAt,
  });
  final String id;
  final String name;
  final String description;
  final String icon;
  final DateTime createdAt;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(
        json['createdAt'],
      ),
      icon: json['icon'] ??
          ''' <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#f5f5f5" viewBox="0 0 256 256"><path d="M232,224H208V32h8a8,8,0,0,0,0-16H40a8,8,0,0,0,0,16h8V224H24a8,8,0,0,0,0,16H232a8,8,0,0,0,0-16ZM88,56h24a8,8,0,0,1,0,16H88a8,8,0,0,1,0-16Zm0,40h24a8,8,0,0,1,0,16H88a8,8,0,0,1,0-16Zm-8,48a8,8,0,0,1,8-8h24a8,8,0,0,1,0,16H88A8,8,0,0,1,80,144Zm72,80H104V184h48Zm16-72H144a8,8,0,0,1,0-16h24a8,8,0,0,1,0,16Zm0-40H144a8,8,0,0,1,0-16h24a8,8,0,0,1,0,16Zm0-40H144a8,8,0,0,1,0-16h24a8,8,0,0,1,0,16Z"></path></svg>''',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      "icon": icon,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
