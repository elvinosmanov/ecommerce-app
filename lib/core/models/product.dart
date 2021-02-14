class Product {
  String id;
  String name;
  String description;
  int price;
  List sizes;
  List images;

  Product(this.id, this.name, this.description, this.price, this.sizes,
      this.images);
  Product.fromMap(Map<String, dynamic> map, String productId) {
    this.name = map['name'] ?? '';
    this.description = map['description'] ?? '';
    this.price = map['price'] ?? '';
    this.sizes = map['size'] ?? '';
    this.images = map['images'] ?? '';
    this.id = productId;
  }
  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'size': sizes,
      'images': images
    };
  }
}
