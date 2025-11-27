class Article {
  final String? author;
  final String title;
  final String? description;
  final String? urlToImage;
  final String sourceName;
  final String? content;

  Article({
    required this.title,
    required this.sourceName,
    this.author,
    this.description,
    this.urlToImage,
    this.content,
  });

  factory Article.fromJson(Map<String,dynamic> json) {
    return Article(
      author: json['author'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      urlToImage: json['urlToImage'] as String?,
      sourceName: (json['source'] != null && json['source']['name'] != null)
          ? json['source']['name'] as String
          : 'Unknown',
      content: json['content'] as String?,
    );
  }
}
