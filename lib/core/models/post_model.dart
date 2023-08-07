class Post {
  int? id;
  String? name;
  String? createdAt;

  Post({this.name, this.id, this.createdAt});

  Post.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    return data;
  }
}
