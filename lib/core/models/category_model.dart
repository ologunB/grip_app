class Category {
  int? id;
  String? name;
  String? createdAt;

  Category({this.name, this.id, this.createdAt});

  Category.fromJson(dynamic json) {
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
