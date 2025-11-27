import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsApi {
  final String apiKey;
  final String base = 'https://newsapi.org/v2/top-headlines';

  NewsApi(this.apiKey);

  Future<List<Article>> fetchTopHeadlines({String country='us', String? category, String? q}) async {
    final params = <String, String>{ 'country': country, 'apiKey': apiKey };
    if (category != null) params['category'] = category;
    if (q != null && q.isNotEmpty) params['q'] = q;

    final uri = Uri.parse(base).replace(queryParameters: params);
    final resp = await http.get(uri);
    if (resp.statusCode != 200) throw Exception('Failed to load news (${resp.statusCode})');
    final data = json.decode(resp.body) as Map<String,dynamic>;
    final articles = (data['articles'] as List<dynamic>).map((a) => Article.fromJson(a)).toList();
    return articles;
  }
}
