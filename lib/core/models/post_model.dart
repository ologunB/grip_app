import 'category_model.dart';
import 'login_model.dart';

class Post {
  int? id;
  String? title;
  int? userId;
  String? bibleBook;
  String? bibleChapter;
  String? bibleVerse;
  String? description;
  String? file;
  String? fileType;
  String? coverImage;
  bool? status;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  List<Category>? categories;
  UserModel? user;

  Post({
    this.id,
    this.title,
    this.userId,
    this.bibleBook,
    this.bibleChapter,
    this.bibleVerse,
    this.description,
    this.file,
    this.fileType,
    this.coverImage,
    this.status,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.user,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    bibleBook = json['bible_book'];
    bibleChapter = json['bible_chapter'];
    bibleVerse = json['bible_verse'];
    description = json['description'];
    file = json['file'];
    fileType = json['file_type'];
    coverImage = json['cover_image'];
    status = json['status'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['id'] = id;
    data['title'] = title;
    data['userId'] = userId;
    data['bible_book'] = bibleBook;
    data['bible_chapter'] = bibleChapter;
    data['bible_verse'] = bibleVerse;
    data['description'] = description;
    data['file'] = file;
    data['file_type'] = fileType;
    data['cover_image'] = coverImage;
    data['status'] = status;
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (categories != null) {
      data['Categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['User'] = user!.toJson();
    }
    return data;
  }
}
