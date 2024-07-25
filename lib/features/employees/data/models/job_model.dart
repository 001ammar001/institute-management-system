import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    super.id,
    required super.name,
    required super.baseSalary,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json["id"],
      name: json["name"],
      baseSalary: json["base_salary"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "base_salary": baseSalary,
    };
  }
}
