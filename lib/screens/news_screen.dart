import 'package:another_news_app/fetch_data.dart';
import 'package:another_news_app/model/article_model.dart';
import 'package:another_news_app/screens/artical_detail_page.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late final FetchData _newsService = FetchData();

  List<Article> _newsArticle = [];
  List<String> _newsCategories = [];

  @override
  void initState() {
    super.initState();
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
          orElse: () => 'general',
        );
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
      print('News Categories: $_newsCategories');
    } catch (e) {
      print('Error fetching categories $e');
      print('Error details: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNewsListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsListView() {
    return _newsArticle.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _newsArticle.length,
            itemBuilder: (context, index) {
              final article = _newsArticle[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Navigate to the details page when a card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleDetailsPage(article: article),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text(index.bitLength.toString()),
                      title: Text(
                        article.source.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        article.source.id ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      // Adjust the ListTile content as per your Article model
                    ),
                  ),
                ),
              );
            },
          );
  }
}

// class ArticleDetailsPage extends StatelessWidget {
//   final Article article;

//   const ArticleDetailsPage({required this.article});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("News"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
            
//             Text(
//               article.author,
//               style: TextStyle(
//                 color: Colors.red,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
