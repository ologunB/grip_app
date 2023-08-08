class Version {
  String? url;
  String? name;
  String? encoding;
  String? abbr;

  Version({this.name, this.url, this.encoding, this.abbr});

  Version.fromJson(dynamic json) {
    url = json['url'];
    name = json['name'];
    encoding = json['encoding'];
    abbr = json['abbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    data['encoding'] = encoding;
    data['abbreviation'] = abbr;
    return data;
  }
}
