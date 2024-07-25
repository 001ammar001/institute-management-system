class StockItemEntity {
  final int? id;
  final String name;
  final int amount;
  final String? source;
  final String? createdAt;
  final String? updatedAt;
  bool index = false;

  StockItemEntity(
      {this.id,
      required this.name,
      required this.amount,
      this.source,
      this.createdAt,
      this.updatedAt});
}
