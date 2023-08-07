class LoginResponse {
  UserModel? user;
  String? token;

  LoginResponse({token, tokens, user});
  LoginResponse.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }

    data['token'] = token;

    return data;
  }
}

class UserModel {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? code;
  String? role;
  bool? verificationStatus;
  bool? isSocial;
  String? image;
  String? googleId;
  String? createdAt;
  String? updatedAt;
  List<String>? category;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.code,
    this.role,
    this.verificationStatus,
    this.isSocial,
    this.image,
    this.googleId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    code = json['code'];
    role = json['role'];
    verificationStatus = json['verification_status'];
    isSocial = json['is_social'];
    image = json['image'];
    googleId = json['googleId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category = json['category']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['code'] = code;
    data['role'] = role;
    data['verification_status'] = verificationStatus;
    data['is_social'] = isSocial;
    data['image'] = image;
    data['googleId'] = googleId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
