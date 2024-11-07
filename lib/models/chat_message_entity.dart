class ChatMessageEntity {
  String id;
  int createdAt;
  String text;
  String? imageUrl;
  Author author;

  ChatMessageEntity(
      {required this.id,
      required this.createdAt,
      required this.text,
      this.imageUrl,
      required this.author});

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
        id: json['id'],
        createdAt: json['createdAt'],
        text: json['text'],
        imageUrl: json['image'],
        author: Author.fromJson(json['author']));
  }
}

class Author {
  String username;

  Author({required this.username});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(username: json['username']);
  }
}
