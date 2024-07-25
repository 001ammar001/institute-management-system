import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';

import '../../../../core/constants.dart';

class RoleListEntity {
  final List<RoleEntity>? roles;
  final Links? links;
  final Meta? meta;

  RoleListEntity({this.roles, this.links, this.meta});
}
