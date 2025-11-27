import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/article.dart';
import 'services/news_api.dart';
import 'viewmodels/news_vm.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  const apiKey = String.fromEnvironment('NEWS_API_KEY', defaultValue: 'YOUR_NEWSAPI_KEY_HERE');
  runApp(MyApp(apiKey));
}

class MyApp extends StatelessWidget {
  final String apiKey;
  MyApp(this.apiKey);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsViewModel(NewsApi(apiKey))..load(),
      child: MaterialApp(home: HomePage()),
    );
  }
}

class HomePage extends StatefulWidget { @override State<HomePage> createState() => _HomePageState(); }
class _HomePageState extends State<HomePage> {
  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchCtrl = TextEditingController();

  @override Widget build(BuildContext context) {
    final vm = Provider.of<NewsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(icon: Icon(Icons.filter_list), onPressed: () => _openFilter(context)),
          IconButton(icon: Icon(Icons.search), onPressed: () => _showSearch(context)),
        ],
      ),
      body: vm.loading && vm.articles.isEmpty ? Center(child: CircularProgressIndicator()) :
      SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          await vm.refresh();
          _refreshController.refreshCompleted();
        },
        child: vm.articles.isEmpty
            ? Center(child: Text('No Results Found'))
            : ListView.builder(
          itemCount: vm.articles.length,
          itemBuilder: (_, i) {
            final a = vm.articles[i];
            return ListTile(
              leading: a.urlToImage != null ? CachedNetworkImage(imageUrl: a.urlToImage!, width: 80, fit: BoxFit.cover) : null,
              title: Text(a.title),
              subtitle: Text(a.sourceName),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(article: a))),
            );
          },
        ),
      ),
    );
  }

  void _openFilter(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) {
      return Wrap(children: [
        ListTile(title: Text('Choose category')),
        ...['business','entertainment','general','health'].map((c) => ListTile(
          title: Text(c),
          onTap: () {
            Provider.of<NewsViewModel>(context, listen:false).load(category: c);
            Navigator.pop(context);
          },
        ))
      ]);
    });
  }

  void _showSearch(BuildContext context) {
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: Text('Search'),
        content: TextField(controller: _searchCtrl, decoration: InputDecoration(suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: () { _searchCtrl.clear(); }))),
        actions: [TextButton(onPressed: () {
          final q = _searchCtrl.text.trim();
          Provider.of<NewsViewModel>(context, listen:false).load(q: q);
          Navigator.pop(context);
        }, child: Text('Search'))],
      );
    });
  }
}

class DetailsScreen extends StatelessWidget {
  final Article article;
  DetailsScreen({required this.article});
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.sourceName)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (article.urlToImage != null) CachedNetworkImage(imageUrl: article.urlToImage!),
          SizedBox(height: 12),
          Text(article.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text('By ${article.author ?? "Unknown"}'),
          SizedBox(height: 12),
          Text(article.description ?? ''),
        ]),
      ),
    );
  }
}
