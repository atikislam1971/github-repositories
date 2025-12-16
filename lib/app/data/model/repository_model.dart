class RepositoryModel {
  final String name;
  final String description;
  final int stars;
  final String ownerName;
  final String ownerAvatar;
  final DateTime updatedAt;


  RepositoryModel( {
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerName,
    required this.ownerAvatar,
    required this.updatedAt,
  });


  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      description: json['description'] ?? 'No description',
      stars: json['stargazers_count'],
      ownerName: json['owner']['login'],
      ownerAvatar: json['owner']['avatar_url'],
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }


  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'stars': stars,
    'ownerName': ownerName,
    'ownerAvatar': ownerAvatar,
    'updatedAt': updatedAt.toIso8601String(),
  };
}