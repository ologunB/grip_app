class Category {
  int? id;
  String? name;
  String? createdAt;
  PostCategories? postCategories;

  Category({this.name, this.postCategories, this.id, this.createdAt});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    postCategories = json['PostCategories'] != null
        ? PostCategories.fromJson(json['PostCategories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name?.toLowerCase();
    data['createdAt'] = createdAt;
    if (postCategories != null) {
      data['PostCategories'] = postCategories!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class PostCategories {
  String? createdAt;
  String? updatedAt;
  int? postId;
  int? categoryId;

  PostCategories(
      {this.createdAt, this.updatedAt, this.postId, this.categoryId});

  PostCategories.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    postId = json['PostId'];
    categoryId = json['CategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['PostId'] = postId;
    data['CategoryId'] = categoryId;
    return data;
  }
}
