// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:altin_fiyatlari/utils/string_extensions.dart';

class NewModel {
  final String title;
  final String description;
  final String image;
  final String url;
  final int id;
  NewModel({
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
      'url': url,
      'id': id,
    };
  }

  factory NewModel.fromMap(Map<dynamic, dynamic> map) {
    return NewModel(
      title: (map['title'] as String).changeG(),
      description: (map['description'] as String).changeG(),
      image: map['image'] as String,
      url: map['url'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewModel.fromJson(String source) =>
      NewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewModel(title: $title, description: $description, image: $image, url: $url)';
  }

  @override
  bool operator ==(covariant NewModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.image == image &&
        other.url == url;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        url.hashCode;
  }
}
