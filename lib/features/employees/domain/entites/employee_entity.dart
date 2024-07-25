import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class EmployeeEntity {
  final int? id;
  final String name;
  final String phoneNumber;
  final String credentials;
  final String birthDate;
  final SearchEntity shift;
  final SearchEntity job;
  final SearchEntity? user;

  EmployeeEntity({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.credentials,
    required this.birthDate,
    required this.shift,
    required this.job,
    this.user,
  });
}
