enum DialogTypeEnum { time, date, list, age , activityFilterType }

extension ArabicDialogName on DialogTypeEnum {
  String getArabicName() {
    switch (name) {
      case "time":
        return "وقت";
      case "date":
        return "تاريخ";
      default:
        return "الوردية";
    }
  }
}

enum SearchTypeEnum {
  room,
  teacher,
  student,
  subject,
  category,
  shifts,
  item,
  job,
  role,
  employee,
  unattachedEmployee,
  unattachedAccount,
}

extension ArabicSearchName on SearchTypeEnum {
  String getArabicName() {
    switch (name) {
      case "item":
        return "مادة";
      case "room":
        return "غرفة";
      case "teacher":
        return "أستاذ";
      case "student":
        return "طالب";
      case "subject":
        return "مادة";
      case "category":
        return "تصنيف";
      case "job":
        return "المسمى الوظيفي";
      case "role":
        return "الدور";
      case "employee" || "unattachedEmployee":
        return "الموظف";
      case "unattachedAccount":
        return "الحساب";
      default:
        return "وردية";
    }
  }
}

extension EndPoint on SearchTypeEnum {
  //TODO Add other APIS
  String getEndPoint() {
    switch (name) {
      case "item":
        return "stocks";
      case "room":
        return "rooms"; //checked
      case "teacher":
        return "teachers/names"; //checked
      case "student":
        return "students/names"; //checked
      case "subject":
        return "subjects"; //checked
      case "category":
        return "categories"; //checked
      case "job":
        return "job-titles"; //checked
      case "role":
        return "roles"; //checked
      case "employee":
        return "employees"; //checked
      case "unattachedEmployee":
        return "employees/unattached";
      case "unattachedAccount":
        return "users/unattached";
      default:
        return "shifts"; //checked
    }
  }
}

enum RoleApiTypeEnum { getRoles, getRolesDetails }
