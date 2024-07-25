import '../../../../core/constants.dart';

class EmployeeModelList {
  List<Employees>? data;
  Links? links;
  Meta? meta;

  EmployeeModelList({this.data, this.links, this.meta});

  EmployeeModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Employees>[];
      json['data'].forEach((v) {
        data!.add(Employees.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      json['links'] = links!.toJson();
    }
    if (meta != null) {
      json['meta'] = meta!.toJson();
    }
    return json;
  }
}

class Employees {
  int? id;
  String? name;
  int? salary;
  String? credentials;
  String? birthDate;
  String? phoneNumber;
  String? createdAt;
  Shift? shift;
  JobTitle? jobTitle;
  Account? account;
  bool index = false;

  Employees(
      {this.id,
      this.name,
      this.salary,
      this.credentials,
      this.birthDate,
      this.phoneNumber,
      this.createdAt,
      this.shift,
      this.jobTitle,
      this.account});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    salary = json['salary'];
    credentials = json['credentials'];
    birthDate = json['birth_date'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
    shift = json['shift'] != null ? Shift.fromJson(json['shift']) : null;
    jobTitle =
        json['job_title'] != null ? JobTitle.fromJson(json['job_title']) : null;
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['salary'] = salary;
    data['credentials'] = credentials;
    data['birth_date'] = birthDate;
    data['phone_number'] = phoneNumber;
    data['created_at'] = createdAt;
    if (shift != null) {
      data['shift'] = shift!.toJson();
    }
    if (jobTitle != null) {
      data['job_title'] = jobTitle!.toJson();
    }
    if (account != null) {
      data['account'] = account!.toJson();
    }
    return data;
  }
}

class Shift {
  int? id;
  String? name;

  Shift({this.id, this.name});

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class JobTitle {
  int? id;
  String? name;
  int? baseSalary;

  JobTitle({this.id, this.name, this.baseSalary});

  JobTitle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseSalary = json['base_salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['base_salary'] = baseSalary;
    return data;
  }
}

class Account {
  int? id;
  String? username;

  Account({this.id, this.username});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    return data;
  }
}

