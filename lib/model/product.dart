import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final String category;
  final String author;
  final String coutry;
  final String description;
  final double price;
  final double price0;
  final String imageUrl;
  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.coutry,
    required this.description,
    required this.price,
    required this.price0,
    required this.imageUrl,
  });

  Product copyWith({
    String? id,
    String? title,
    String? category,
    String? author,
    String? language,
    String? coutry,
    String? description,
    double? price,
    double? price0,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      author: author ?? this.author,
      coutry: coutry ?? this.coutry,
      description: description ?? this.description,
      price: price ?? this.price,
      price0: price0 ?? this.price0,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'author': author,
      'coutry': coutry,
      'description': description,
      'price': price,
      'price0': price0,
      'imageUrl': imageUrl,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      author: json['author'],
      coutry: json['coutry'],
      description: json['description'],
      price: json['price'],
      price0: json['price0'],
      imageUrl: json['imageUrl'],
    );
  }
}
