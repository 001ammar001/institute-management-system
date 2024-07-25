import 'package:institute_management_system/features/warehouse/domain/entitys/stock_item_entity.dart';

class StockItemModel extends StockItemEntity {
  StockItemModel({
    super.id,
    required super.name,
    required super.amount,
    required super.source,
    super.createdAt,
    super.updatedAt,
  });

  factory StockItemModel.fromJson(Map<String, dynamic> json) {
    return StockItemModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      source: json['source'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "amount": amount,
      "source": source,
    };
  }
}
