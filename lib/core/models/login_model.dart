import 'category_model.dart';

class LoginModel {
  UserModel? user;
  String? token;

  LoginModel({token, tokens, user});
  LoginModel.fromJson(dynamic json) {
    token = json['token'];
    user = UserModel.fromJson(json['user'] ?? json['userData'] ?? {});
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
  String? followersCount;
  String? followingCount;
  List<Category>? categories;

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
    this.categories,
    this.followersCount,
    this.followingCount,
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
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    categories = [];
    json['categories']?.forEach((v) {
      categories!.add(Category.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories'] = categories!.map((v) => v.toJson()).toList();
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
    data['followersCount'] = followersCount;
    data['followingCount'] = followingCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
