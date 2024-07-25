import 'package:flutter/material.dart';

class SearchEntity extends ChangeNotifier {
  int id;
  String name;

  SearchEntity({int? id, String? name})
      : id = id ?? 0,
        name = name ?? "";

  factory SearchEntity.fromJson(Map<String, dynamic> json) {
    return SearchEntity(
      id: json["id"],
      name: json["name"] ?? json["category"] ?? json["username"],
    );
  }

  void reset() {
    id = 0;
    name = "";
    notifyListeners();
  }

  void update(SearchEntity searchEnity) {
    id = searchEnity.id;
    name = searchEnity.name;
    notifyListeners();
  }
}
