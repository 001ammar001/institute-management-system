import 'package:institute_management_system/features/accounts/domain/entites/permission_entity.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';

import '../../../../core/utils/enums.dart';

class RoleModel extends RoleEntity {
  RoleModel({
    super.id,
    required super.name,
    required super.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json, RoleApiTypeEnum api) {
    final data = json["permissions"] as List;
    final permissions = data.map((json) => PermissionEntity(name: json)).toList();
    if(api == RoleApiTypeEnum.getRolesDetails){
      return RoleModel(
        id: json["role"]["id"],
        name: json["role"]["name"],
        permissions: permissions,
      );
    }else{
      return RoleModel(
          id: json["id"],
          name: json["name"],
          permissions: permissions,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "role": name,
      "permissions": permissions.map((e) => e.id).toList().join(",")
    };
  }
}
