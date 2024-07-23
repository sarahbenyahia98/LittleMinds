// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class YoutubeModel {
  final String id;
  final String title;
  final String description;
  final String url;
  YoutubeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
  });

  YoutubeModel copyWith({
    String? id,
    String? title,
    String? description,
    String? url,
  }) {
    return YoutubeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'url': url,
    };
  }

  factory YoutubeModel.fromMap(Map<String, dynamic> map) {
    return YoutubeModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory YoutubeModel.fromJson(String source) =>
      YoutubeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'YoutubeModel(id: $id, title: $title, description: $description, url: $url)';
  }

  @override
  bool operator ==(covariant YoutubeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode;
  }
}
