class GuideModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> moods;
  final bool featuredThisWeek;
  final bool active;

  const GuideModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.moods,
    required this.featuredThisWeek,
    required this.active,
  });

  factory GuideModel.fromJson(
    Map<String, dynamic> json,
    String id,
  ) {
    return GuideModel(
      id: id,
      title: json['title'] ?? '',
      description:
          json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? 'free',
      moods:
          List<String>.from(
            json['moods'] ?? [],
          ),
      featuredThisWeek:
          json['featuredThisWeek'] ?? false,
      active: json['active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'moods': moods,
      'featuredThisWeek':
          featuredThisWeek,
      'active': active,
    };
  }

  GuideModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? category,
    List<String>? moods,
    bool? featuredThisWeek,
    bool? active,
  }) {
    return GuideModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description:
          description ??
          this.description,
      imageUrl:
          imageUrl ?? this.imageUrl,
      category:
          category ?? this.category,
      moods: moods ?? this.moods,
      featuredThisWeek:
          featuredThisWeek ??
          this.featuredThisWeek,
      active: active ?? this.active,
    );
  }
}