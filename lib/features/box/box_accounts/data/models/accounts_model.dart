class AccountModelList {
  List<BoxAccount>? data;

  AccountModelList({this.data});

  AccountModelList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BoxAccount>[];
      json['data'].forEach((v) {
        data!.add(BoxAccount.fromJson(v));
      });
    }
  }
}

class BoxAccount {
  int? id;
  String? name;
  bool? index=false;

  BoxAccount({this.id, this.name});

  BoxAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
