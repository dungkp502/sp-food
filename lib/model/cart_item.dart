class CartItem {
  final String? id;
  final String? productId;
  final String title;
  final int quantity;
  final double price;
  final double price0;
  final String imageUrl;
  final String category;
  final String author;
  final String coutry;
  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.price0,
    required this.imageUrl,
    required this.category,
    required this.author,
    required this.coutry,
  });
  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    int? quantity,
    double? price,
    double? price0,
    String? imageUrl,
    String? category,
    String? author,
    String? coutry,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      price0: price0 ?? this.price0,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      author: author ?? this.author,
      coutry: coutry ?? this.coutry,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'quantity': quantity,
      'price': price,
      'price0': price0,
      'imageUrl': imageUrl,
      'category': category,
      'author': author,
      'coutry': coutry,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      price0: json['price0'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      author: json['author'],
      coutry: json['coutry'],
    );
  }
}
