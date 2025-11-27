import 'package:flutter/foundation.dart';
import '../models/article.dart';
import '../services/news_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsApi api;
  List<Article> articles = [];
  List<Article> _cache = [];
  bool loading = false;
  String? selectedCategory;
  String? lastQuery;

  NewsViewModel(this.api);

  Future<void> load({String? category, String? q, bool force=false}) async {
    loading = true; notifyListeners();
    // if offline and we have cache and no force, return local filtered results
    final conn = await Connectivity().checkConnectivity();
    final isOnline = conn != ConnectivityResult.none;
    if (!isOnline && _cache.isNotEmpty && !force) {
      articles = _filterLocal(_cache, category: category, q: q);
      loading = false; notifyListeners();
      return;
    }
    try {
      final fetched = await api.fetchTopHeadlines(category: category, q: q);
      _cache = fetched;
      articles = _filterLocal(_cache, category: category, q: q);
      selectedCategory = category;
      lastQuery = q;
    } catch (e) {
      // keep previous articles or empty
      // optionally set error variable
    } finally {
      loading = false; notifyListeners();
    }
  }

  List<Article> _filterLocal(List<Article> input, {String? category, String? q}) {
    var out = input;
    if (q != null && q.isNotEmpty) {
      final ql = q.toLowerCase();
      out = out.where((a) => (a.title.toLowerCase().contains(ql) || (a.description?.toLowerCase().contains(ql) ?? false))).toList();
    }
    return out;
  }

  Future<void> refresh() async => await load(category: selectedCategory, q: lastQuery, force:true);
}
