class AppUserModel {
  String? userId;
  String? name;
  String? email;
  String? tocken;

  AppUserModel({this.userId, this.name, this.email, this.tocken});

  AppUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    tocken = json['tocken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['tocken'] = this.tocken;
    return data;
  }
}
