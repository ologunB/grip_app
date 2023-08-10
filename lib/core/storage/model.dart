import 'package:objectbox/objectbox.dart';

@Entity()
class Verse {
  @Id(assignable: true)
  int absoluteVerse;
  int absoluteChapter;
  int chapter;
  int verse;
  String name;
  String book;
  String text;

  Verse(
    this.text,
    this.name,
    this.book,
    this.chapter,
    this.verse,
    this.absoluteChapter,
    this.absoluteVerse,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['chapter'] = chapter;
    data['verse'] = verse;
    data['absoluteChapter'] = absoluteChapter;
    data['absoluteVerse'] = absoluteVerse;
    data['name'] = name;
    data['book'] = book;
    data['text'] = text;
    return data;
  }
}
