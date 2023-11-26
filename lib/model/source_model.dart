
class Source {
  Source({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.url,
    required this.language,
    required this.country,
  });

  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        url: json['url']?? '',
        language: json['language']?? '',
        country: json['country']?? '',
        category: json['category']?? '');
  }
}