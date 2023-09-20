import 'category_model.dart';
import 'login_model.dart';

class Post {
  int? id;
  String? title;
  String? bibleBook;
  int? userId;
  String? bibleChapter;
  String? bibleVerse;
  String? description;
  String? file;
  String? fileType;
  String? coverImage;
  String? createdAt;
  bool? status;
  String? updatedAt;
  String? likeCount;
  String? link;
  String? commentCount;
  List<Category>? categories;
  UserModel? user;
  bool? isLiked;
  bool? isBooked;
  bool? isFollow;

  Post({
    this.id,
    this.title,
    this.bibleBook,
    this.userId,
    this.bibleChapter,
    this.bibleVerse,
    this.description,
    this.file,
    this.fileType,
    this.coverImage,
    this.createdAt,
    this.status,
    this.updatedAt,
    this.likeCount,
    this.commentCount,
    this.categories,
    this.user,
    this.isBooked,
    this.isFollow,
    this.isLiked,
    this.link,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bibleBook = json['bible_book'];
    userId = json['userId'];
    link = json['link'];
    bibleChapter = json['bible_chapter'];
    bibleVerse = json['bible_verse'];
    description = json['description'];
    file = json['file'];
    fileType = json['file_type'];
    coverImage = json['cover_image'];
    createdAt = json['createdAt'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    likeCount = json['likeCount'];
    isBooked = json['isBooked'] ?? false;
    isFollow = json['isFollow'] ?? false;
    isLiked = json['isLiked'] ?? false;
    commentCount = json['CommentCount'];
    if (json['Categories'] != null) {
      categories = <Category>[];
      json['Categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    user = json['User'] != null ? UserModel.fromJson(json['User']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isBooked'] = isBooked;
    data['isFollow'] = isFollow;
    data['link'] = link;
    data['isLiked'] = isLiked;
    data['id'] = id;
    data['title'] = title;
    data['bible_book'] = bibleBook;
    data['userId'] = userId;
    data['bible_chapter'] = bibleChapter;
    data['bible_verse'] = bibleVerse;
    data['description'] = description;
    data['file'] = file;
    data['file_type'] = fileType;
    data['cover_image'] = coverImage;
    data['createdAt'] = createdAt;
    data['status'] = status;
    data['updatedAt'] = updatedAt;
    data['likeCount'] = likeCount;
    data['CommentCount'] = commentCount;
    if (categories != null) {
      data['Categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}
