import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class UserEntity {
  final int? id;
  final String username;
  final String password;
  final SearchEntity role;
  final SearchEntity? employee;

  const UserEntity({
    this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.employee,
  });
}

class UserDetailsEntity {
  final int? id;
  final String username;
  final SearchEntity role;
  final SearchEntity? employee;
  final List<UserActivityInfo>? userActivityInfo;

  const UserDetailsEntity(
      {this.id,
      required this.username,
      required this.role,
      this.employee,
      required this.userActivityInfo});
}

class UserActivityInfo {
  String activity;
  String date;
  UserActivityInfo({required this.activity, required this.date});
}
