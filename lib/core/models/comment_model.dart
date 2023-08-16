import 'login_model.dart';

class Comment {
  int? id;
  String? text;
  String? createdAt;
  String? likesCount;
  UserModel? user;

  Comment({this.text, this.id, this.createdAt, this.user, this.likesCount});

  Comment.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'];
    likesCount = json['likesCount'];
    createdAt = json['createdAt'];
    user = json['User'] != null ? UserModel.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['likesCount'] = likesCount;
    data['createdAt'] = createdAt;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}
