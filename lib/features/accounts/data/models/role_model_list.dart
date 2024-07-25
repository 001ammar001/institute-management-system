import 'package:institute_management_system/features/accounts/data/models/role_model.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_list_entity.dart';

import '../../../../core/constants.dart';
import '../../../../core/utils/enums.dart';

class RoleModelList extends RoleListEntity{
  RoleModelList({
    required super.roles,
    required super.links,
    required super.meta,
  });

  factory RoleModelList.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List;
    final roles = data.map((json) => RoleModel.fromJson(json,RoleApiTypeEnum.getRoles)).toList();
    return  RoleModelList(
      roles: roles,
      links: Links.fromJson(json['links']) ,
      meta: Meta.fromJson(json['meta']) ,
    );
  }

}

