import 'login_model.dart';

class Comment {
  int? id;
  int? postId;
  int? userId;
  String? comment;
  String? createdAt;
  String? likesCount;
  bool? isLike;
  UserModel? user;

  Comment({
    this.comment,
    this.id,
    this.createdAt,
    this.user,
    this.likesCount,
    this.userId,
    this.postId,
    this.isLike,
  });

  Comment.fromJson(dynamic json) {
    id = json['id'];
    comment = json['comment'];
    postId = json['postId'];
    userId = json['userId'];
    likesCount = json['commentLikeCount'];
    createdAt = json['createdAt'];
    isLike = json['isLike'];
    user = json['User'] != null ? UserModel.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isLike'] = isLike;
    data['comment'] = comment;
    data['postId'] = postId;
    data['userId'] = userId;
    data['commentLikeCount'] = likesCount;
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
