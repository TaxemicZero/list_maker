class Tobuy {
  int? id;
  String name;
  double? price;
  int? amount;

  Tobuy({
    this.id,
    required this.name,
    this.price,
    this.amount
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'amount': amount,
    };
  }
}