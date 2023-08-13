import 'dart:convert';

import 'package:hexcelon/core/apis/base_api.dart';
import 'package:path_provider/path_provider.dart';

import '../../views/widgets/utils.dart';
import 'model.dart';
import 'objectbox.g.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ObjectBox {
  /// The Store of this app.
  late final Store? _store;

  /// A Box of verses.
  late final Box<Verse> _verseBox;

  Box<Verse> get verseBox => _verseBox;

  ObjectBox._create(this._store) {
    _verseBox = Box<Verse>(_store!);
    putAllData();
  }

  static Future<ObjectBox> create() async {
    String devicePath = (await getApplicationDocumentsDirectory()).path;
    final store = await openStore(directory: '$devicePath/bible');
    return ObjectBox._create(store);
  }

  Future<void> putAllData() async {
    DateTime now = DateTime.now();
    String? version = AppCache.getDefaultBible();
    if (version == null) return;
    await _verseBox.removeAllAsync();
    int chapter = 1;
    int verse = 1;
    final verses = <Verse>[];
    String devicePath = (await getApplicationDocumentsDirectory()).path;
    final File savedFile = File('$devicePath/Bibles/$version');

    final String _ = await savedFile.readAsString();
    final List books = jsonDecode(_)['books'];
    Map<String, dynamic> all = {};

    for (dynamic b in books) {
      List<int> temp = [];
      for (dynamic c in b['chapters']) {
        temp.add(c['verses'].length);
        for (dynamic v in c['verses']) {
          verses.add(
            Verse(
              b['name'],
              c['name'],
              v['name'],
              v['text'],
              v['chapter'],
              v['verse'],
              chapter,
              verse,
            ),
          );
          verse = verse + 1;
        }
        chapter = chapter + 1;
      }
      all.putIfAbsent(b['name'], () => temp);
    }
    Utils.allBooks = all;
    await _verseBox.putManyAsync(verses);
    print(
        'Run time is ${DateTime.now().difference(now).inMilliseconds} for ${books.length} books');
  }

  List<Verse> get2ChaptersBeforeAndAfter(int absoluteChapter) {
    Query<Verse> query = _verseBox
        .query(Verse_.absoluteChapter
            .equals(absoluteChapter - 2)
            .or(Verse_.absoluteChapter.equals(absoluteChapter - 1))
            .or(Verse_.absoluteChapter.equals(absoluteChapter))
            .or(Verse_.absoluteChapter.equals(absoluteChapter + 1))
            .or(Verse_.absoluteChapter.equals(absoluteChapter + 2)))
        .order(Verse_.absoluteVerse)
        .build();
    List<Verse> all = query.find();
    query.close();

    return all;
  }

  List<Verse> searchText(String q) {
    Query<Verse> query = _verseBox
        .query(Verse_.text
            .contains(q, caseSensitive: false)
            .or(Verse_.verseName.contains(q, caseSensitive: false)))
        .order(Verse_.absoluteVerse)
        .build();
    List<Verse> all = query.find();
    query.close();

    return all;
  }

  List<Verse> get2ChaptersAfter(int absoluteChapter) {
    Query<Verse> query = _verseBox
        .query(Verse_.absoluteChapter
            .equals(absoluteChapter + 1)
            .or(Verse_.absoluteChapter.equals(absoluteChapter + 2)))
        .order(Verse_.absoluteVerse)
        .build();
    List<Verse> all = query.find();
    query.close();

    return all;
  }

  List<Verse> get2ChaptersBefore(int absoluteChapter) {
    Query<Verse> query = _verseBox
        .query(Verse_.absoluteChapter
            .equals(absoluteChapter - 1)
            .or(Verse_.absoluteChapter.equals(absoluteChapter - 2)))
        .order(Verse_.absoluteVerse)
        .build();
    List<Verse> all = query.find();
    query.close();

    return all;
  }

  Verse getOneVerse(String book, int chapter, {int? verse}) {
    Query<Verse> query = _verseBox
        .query(Verse_.chapter
            .equals(chapter)
            .and(Verse_.bookName.equals(book))
            .and(Verse_.verse.equals(verse ?? 1)))
        .build();
    List<Verse> all = query.find();
    query.close();

    return all.first;
  }
}
