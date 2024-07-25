import 'package:institute_management_system/features/warehouse/data/models/stock_item_model.dart';

import '../../../../core/constants.dart';

class WareHouseModelList {
  List<StockItemModel>? data;
  Links? links;
  Meta? meta;

  WareHouseModelList({this.data, this.links, this.meta});

  WareHouseModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StockItemModel>[];
      json['data'].forEach((v) {
        data!.add(StockItemModel.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}
