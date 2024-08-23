class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final Rating rating;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
  });
}
