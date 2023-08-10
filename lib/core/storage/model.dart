import 'package:objectbox/objectbox.dart';

@Entity()
class Verse {
  @Id(assignable: true)
  int absoluteVerse;
  int absoluteChapter;
  int chapter;
  int verse;
  String verseName;
  String chapterName;
  String bookName;
  String text;

  Verse(
    this.bookName,
    this.chapterName,
    this.verseName,
    this.text,
    this.chapter,
    this.verse,
    this.absoluteChapter,
    this.absoluteVerse,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Verse && other.absoluteVerse == absoluteVerse;
  }

  @override
  int get hashCode => absoluteVerse.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookName'] = bookName;
    data['chapterName'] = chapterName;
    data['verseName'] = verseName;
    data['chapter'] = chapter;
    data['verse'] = verse;
    data['absoluteChapter'] = absoluteChapter;
    data['absoluteVerse'] = absoluteVerse;
    data['text'] = text;
    return data;
  }
}
