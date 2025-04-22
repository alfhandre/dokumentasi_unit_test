class Book {
  String id;
  String name;
  int price;

  Book(this.id, this.name, this.price);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.id == id &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;
}
