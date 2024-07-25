class PermissionEntity {
  final int? id;
  final String name;

  PermissionEntity({int? id, required this.name}) : id = id ?? 0;

  factory PermissionEntity.fromJson(Map<String, dynamic> json) {
    return PermissionEntity(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return name;
  }
}
