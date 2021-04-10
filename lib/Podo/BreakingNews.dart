class BreakingNews {
  String status;
  int totalResults;
  List<Articles> articles;

  BreakingNews({String status, int totalResults, List<Articles> articles}) {
    this.status = status;
    this.totalResults = totalResults;
    this.articles = articles;
  }

  factory BreakingNews.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['articles'] as List;

    List<Articles> articlesList =
        list != null ? list.map((i) => Articles.fromJson(i)).toList() : null;

    return new BreakingNews(
      status: parsedJson['status'],
      totalResults: parsedJson['totalResults'],
      articles: parsedJson['articles'] != null ? articlesList : null,
    );
  }
}

class Articles {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles(
      {Source source,
      String author,
      String title,
      String description,
      String url,
      String urlToImage,
      String publishedAt,
      String content}) {
    this.source = source;
    this.author = author;
    this.title = title;
    this.description = description;
    this.url = url;
    this.urlToImage = urlToImage;
    this.publishedAt = publishedAt;
    this.content = content;
  }

  factory Articles.fromJson(Map<String, dynamic> parsedJson) {
    return new Articles(
      source: parsedJson['source'] != null
          ? new Source.fromJson(parsedJson['source'])
          : null,
      author: parsedJson['author'],
      title: parsedJson['title'],
      description: parsedJson['description'],
      url: parsedJson['url'],
      urlToImage: parsedJson['urlToImage'],
      publishedAt: parsedJson['publishedAt'],
      content: parsedJson['content'],
    );
  }
}

class Source {
  String id;
  String name;

  Source({String id, String name}) {
    this.id = id;
    this.name = name;
  }

  factory Source.fromJson(Map<String, dynamic> parsedJson) {
    return new Source(
      id: parsedJson['id'],
      name: parsedJson['name'],
    );
  }
}
