import 'dart:convert';

import 'package:another_news_app/model/source_model.dart';
import 'package:http/http.dart' as http;

import 'package:another_news_app/model/article_model.dart';

class FetchData {
  final String apiKey = 'a05536041fdf4abb9ee87f6747d8e490';

  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> getArticles() async {
    final Uri url =
        Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey');

    try {
      final response = await http.get(url);
      print('Top Headlines Data: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['articles'] != null) {
          final List<dynamic> articleJson = responseData['articles'];
          final List<Article> articles =
              articleJson.map((json) {return Article.fromJson(json, sourceCategory: json['source']['category']);}).toList();
          print('Articles: ${response.body}');
          return articles;
        } else {
          print('Invalid API response: $responseData');
          throw Exception('No articles found in the response.');
        }
      } else {
        print(
            'Failed to load top headlines. Status Code: ${response.statusCode}');
        throw Exception(
            'Failed to load top headlines. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<String>> getSourceCategories() async {
    final Uri url = Uri.parse('$baseUrl/sources?apiKey=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> sourcesJson = json.decode(response.body)['sources'];
        final List<String> categories = sourcesJson
            .map((json) => Source.fromJson(json).category)
            .toSet() // Use a Set to get unique categories
            .toList();

        print('Categories:$categories');

        return categories;
      } else {
        throw Exception(
            'Failed to load sources. Status Code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow; // Rethrow the exception for further handling, if needed
    }
  }
}
