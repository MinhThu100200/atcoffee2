class Category {
  int id;
  String name;
  Category({this.id, this.name});
}

class Size {
  String size;
  dynamic price;
  Size({this.size, this.price});
}

class Product {
  int id;
  String name;
  String description;
  String image;
  dynamic price;
  dynamic rate;
  int count;
  int discount;
  List<Size> sizes;
  Product(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.count,
      this.rate,
      this.discount,
      this.sizes});
}
