class ItemSize {

  ItemSize({this.name, this.price, this.stock});

  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  bool get hasStock => stock > 0;

  ItemSize clone() {
    return ItemSize(
      name: name,
      price: price,
      stock: stock,
    );
  }

  String name;
  num price;
  int stock;

}