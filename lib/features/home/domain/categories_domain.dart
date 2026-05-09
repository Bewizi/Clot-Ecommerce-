import 'package:equatable/equatable.dart';

class CategoriesDomain extends Equatable {
  const CategoriesDomain({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoriesDomain.fromJson(Map<String, dynamic> json) {
    return CategoriesDomain(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image_url'] as String? ?? '',
    );
  }
  final String id;
  final String name;
  final String image;

  CategoriesDomain copyWith({
    String? id,
    String? name,
    String? image,
  }) {
    return CategoriesDomain(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, name, image];

  // @override
  // bool? get stringify => true;
}
