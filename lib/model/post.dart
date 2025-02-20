class Post{
  int id;
  String title;
  String body;
  List<String> tags;
  int likes;
  int dislikes;
  int views;
  int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.likes,
    required this.dislikes,
    required this.views,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      tags: (json['tags'] as List?)?.map((item) => item as String).toList() ?? [],
      likes: json["reactions"]["likes"],
      dislikes: json["reactions"]["dislikes"],
      views: json["views"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "tags": tags,
      "likes": likes,
      "dislikes": dislikes,
      "views": views,
      "userId": userId,
    };
  }

  static List<Post> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Post.fromJson(json)).toList();
  }
}