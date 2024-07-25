import 'package:institute_management_system/features/accounts/domain/entites/permission_entity.dart';

class RoleEntity {
  final int? id;
  final String name;
  final List<PermissionEntity> permissions;
  bool index = false;

  RoleEntity({this.id, String? name, List<PermissionEntity>? permissions})
      : name = name ?? "",
        permissions = permissions ?? [];

  factory RoleEntity.fromJson(Map<String, dynamic> json) {
    final data = json["permissions"] as List;
    final permissions = data.map((json) => PermissionEntity(name: json)).toList();
    return RoleEntity(
      id: json["id"],
      name: json["name"],
      permissions: permissions,
    );
  }
}
