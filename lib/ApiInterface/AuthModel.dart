class AuthModel {
  int status;
  Null error;
  String messages;
  List<Data> data;

  AuthModel({this.status, this.error, this.messages, this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    messages = json['messages'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String idUser;
  String name;
  String username;
  String password;
  String level;

  Data({this.idUser, this.name, this.username, this.password, this.level});

  Data.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['level'] = this.level;
    return data;
  }
}
