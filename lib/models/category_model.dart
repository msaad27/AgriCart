class Category {
  final String id;
  final String title;
  final String iconPath;

  const Category({
    required this.id,
    required this.title,
    required this.iconPath,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      title: map['title'] as String,
      iconPath: map['iconPath'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'iconPath': iconPath,
      };

  Category copyWith({String? id, String? title, String? iconPath}) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
    );
  }
}
