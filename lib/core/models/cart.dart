class Cart {
  String size;
  String id;
  Cart(this.size, this.id);
  Cart.fromMap(Map map, String id) {
    this.size = map['size'];
    this.id = id;
  }
  toJson() {
    return {'size': this.size};
  }
}
