class Products {
  final int? id;
  final String? title;
  final String? description;
  final double? price; // Change to double
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String>? images;

  Products({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  Products.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        price = (json['price'] as num?)?.toDouble(), // Convert to double
        discountPercentage = json['discountPercentage'] as double?,
        rating = json['rating'] as double?,
        stock = json['stock'] as int?,
        brand = json['brand'] as String?,
        category = json['category'] as String?,
        thumbnail = json['thumbnail'] as String?,
        images = (json['images'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'stock': stock,
    'brand': brand,
    'category': category,
    'thumbnail': thumbnail,
    'images': images,
  };
}
