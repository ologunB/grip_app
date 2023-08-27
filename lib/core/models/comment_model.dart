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

class NotificationModel {
  int? id;
  int? userId;
  String? message;
  bool? isRead;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
      this.userId,
      this.message,
      this.isRead,
      this.createdAt,
      this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    message = json['message'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['message'] = message;
    data['isRead'] = isRead;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
