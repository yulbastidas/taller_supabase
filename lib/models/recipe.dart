class Recipe {
  final int? id;
  final String name;
  final String ingredients;

  Recipe({this.id, required this.name, required this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int?,
      name: json['name'] as String,
      ingredients: json['ingredients'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'ingredients': ingredients};
  }
}
