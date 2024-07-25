import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';

class StudentModel extends StudentEnity {
  StudentModel(
      {super.id,
      required super.aName,
      required super.eName,
      required super.fArName,
      required super.fEnName,
      required super.mArName,
      required super.mEnName,
      required super.phoneNumber,
      required super.lineNumber,
      required super.nationalNumber,
      required super.gender,
      required super.birthDate,
      required super.nationality,
      required super.educationLevel});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        id: json["id"],
        aName: json["name"],
        eName: json["name_en"],
        fArName: json["father_name"],
        fEnName: json["father_name_en"],
        mArName: json["mother_name"],
        mEnName: json["mother_name_en"],
        phoneNumber: json["phone_number"],
        lineNumber: json["line_phone_number"],
        nationalNumber: json["national_number"],
        gender: json["gender"],
        birthDate: json["birth_date"],
        nationality: json["nationality"],
        educationLevel: json["education_level"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": aName,
      "name_en": eName,
      "father_name": fArName,
      "father_name_en": fEnName,
      "mother_name": mArName,
      "mother_name_en": mEnName,
      "phone_number": phoneNumber,
      "line_phone_number": lineNumber,
      "national_number": nationalNumber,
      "gender": gender,
      "education_level": educationLevel,
      "birth_date": birthDate,
      "nationality": nationality
    };
  }
}
