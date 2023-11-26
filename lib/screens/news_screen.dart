import 'package:another_news_app/fetch_data.dart';
import 'package:another_news_app/model/article_model.dart';
import 'package:another_news_app/model/source_model.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  @override
  State<NewsScreen> createState() {
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<NewsScreen> {
  late final _newsService = FetchData();

  List<Article> _newsArticle = [];
  List<String> _newsCategories = [];

  @override
  void initState() {
    fetchData();
    fetchCategories();
  }

  Future<void> fetchData() async {
    try {
      final List<Article> articles = await _newsService.getArticles();
      final List<String> categories = await _newsService.getSourceCategories();

      for (var article in articles) {
        final matchingSource = categories.firstWhere(
            (sourceCategory) => sourceCategory == article.sourceCategory,
            orElse: () => 'general');
        article.category = matchingSource;
        print(
            'Article Title: ${article.title}, Source Category: ${article.sourceCategory}');
      }
      setState(() {
        _newsArticle = articles;
      });
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error fetching data: $e');
      print('Error details: ${e.toString()}');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final List<String> categories = await _newsService.getSourceCategories();
      setState(() {
        _newsCategories = categories;
      });
      print('News Categies: $_newsCategories');
    } catch (e) {
      print('Error fetching categories $e');
      print('Error details: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News'), actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ]),
    );
  }
}
