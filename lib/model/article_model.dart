import 'source_model.dart';

class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  String category;
  final String sourceCategory;
  final String sourceId;
  final String id;
  final Source source;
  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.category,
    required this.sourceCategory,
    required this.sourceId,
    required this.id,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json, {required sourceCategory}) {
    return Article(
        author: json['author'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        url: json['url'] ?? '',
        urlToImage: json['urlToImage'] ?? '',
        publishedAt: json['publishedAt'] ?? '',
        content: json['content'] ?? '',
        category: json['category'] ?? '',
        sourceCategory: json['source']['category'] ?? '',
        id: json['id'] ?? '',
        sourceId: json['source']['id'] ?? '',
        source: Source.fromJson(
          json['source'] ?? {},
        ));
  }
  @override
  String toString() {
    return 'Article{title: $title, category: $category, url: $url}';
  }
}
