class News {
  final String title;
  final String url;
  final String imageUrl;
  final String summary;

  News({
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.summary,
  });

  factory News.fromJson(Map data) {
    return News(
      title: data['title'],
      url: data['url'],
      imageUrl: data['image_url'],
      summary: data['summary'],
    );
  }
}

class NewsResponse {
  final List<News> results;

  NewsResponse({required this.results});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var launchList = (json['results'] as List)
        .map((launchJson) => News.fromJson(launchJson))
        .toList();

    return NewsResponse(results: launchList);
  }
}
