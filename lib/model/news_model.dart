// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewModel {
  final String title;
  final String description;
  final String image;
  final String url;
  NewModel({
    required this.title,
    required this.description,
    required this.image,
    required this.url,
  });

  NewModel copyWith({
    String? title,
    String? description,
    String? image,
    String? url,
  }) {
    return NewModel(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
      'url': url,
    };
  }

  factory NewModel.fromMap(Map<dynamic, dynamic> map) {
    return NewModel(
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewModel.fromJson(String source) => NewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewModel(title: $title, description: $description, image: $image, url: $url)';
  }

  @override
  bool operator ==(covariant NewModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.description == description && other.image == image && other.url == url;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ image.hashCode ^ url.hashCode;
  }
}
