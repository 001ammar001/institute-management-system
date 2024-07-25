import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class EmployeeModelL extends EmployeeEntity {
  EmployeeModelL({
    super.id,
    required super.name,
    required super.phoneNumber,
    required super.credentials,
    required super.birthDate,
    required super.shift,
    required super.job,
    super.user,
  });

  factory EmployeeModelL.fromJson(Map<String, dynamic> json) {
    return EmployeeModelL(
      name: json["name"],
      phoneNumber: json["phone_number"],
      credentials: json["credentials"],
      birthDate: json["birth_date"],
      shift: SearchEntity.fromJson(json["shift"]),
      job: SearchEntity.fromJson(json["job_title"]),
      user: json["account"] != null
          ? SearchEntity.fromJson(json["account"])
          : SearchEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone_number": phoneNumber,
      "credentials": credentials,
      "birth_date": birthDate,
      "job_title_id": job.id,
      "shift_id": shift.id,
      "user_id": user?.id,
    };
  }
}
