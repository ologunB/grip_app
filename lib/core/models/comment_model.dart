import 'login_model.dart';

class Comment {
  int? id;
  int? postId;
  int? userId;
  String? comment;
  String? createdAt;
  String? likesCount;
  UserModel? user;

  Comment({
    this.comment,
    this.id,
    this.createdAt,
    this.user,
    this.likesCount,
    this.userId,
    this.postId,
  });

  Comment.fromJson(dynamic json) {
    id = json['id'];
    comment = json['comment'];
    postId = json['postId'];
    userId = json['userId'];
    likesCount = json['likesCount'];
    createdAt = json['createdAt'];
    user = json['User'] != null ? UserModel.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['postId'] = postId;
    data['userId'] = userId;
    data['likesCount'] = likesCount;
    data['createdAt'] = createdAt;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}
