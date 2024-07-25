part of 'role_details_bloc.dart';

enum RoleStatus { loading, loaded, failure }

class RoleDetailsState extends Equatable {
  final RoleStatus status;
  final List<PermissionEntity> permissions;
  final List<bool> chosedPermissions;
  final RoleEntity role;
  final String? message;

  RoleDetailsState(
      {RoleStatus? status,
      RoleEntity? role,
      List<PermissionEntity>? permissions,
      this.message})
      : status = status ?? RoleStatus.loading,
        role = role ?? RoleEntity(),
        permissions = permissions ?? [],
        chosedPermissions = permissions == null
            ? []
            : permissions.map((entity) {
                if (role != null && role.permissions.isNotEmpty) {
                  return role.permissions
                      .where((permission) => entity.name == permission.name)
                      .isNotEmpty;
                }
                return false;
              }).toList();

  RoleDetailsState copyWith({
    RoleStatus? status_,
    List<PermissionEntity>? permissions_,
    RoleEntity? role_,
    String? message_,
  }) {
    return RoleDetailsState(
        message: message_ ?? message,
        permissions: permissions_ ?? permissions,
        role: role_ ?? role,
        status: status_ ?? status);
  }

  List<PermissionEntity> mapPermissions() {
    List<PermissionEntity> list = [];
    for (int i = 0; i < chosedPermissions.length; i++) {
      if (chosedPermissions[i]) {
        list.add(permissions[i]);
      }
    }
    return list;
  }

  @override
  List<Object> get props => [status, chosedPermissions];
}
