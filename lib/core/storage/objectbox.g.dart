// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1612273717797023081),
      name: 'Verse',
      lastPropertyId: const IdUid(11, 8502944586431456524),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1903043599683870365),
            name: 'absoluteVerse',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 280294695729124714),
            name: 'absoluteChapter',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2919811762595181484),
            name: 'verse',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2946412213584161899),
            name: 'chapterName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7425875722405581382),
            name: 'text',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 3502642703612911409),
            name: 'chapter',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 2539858344695679808),
            name: 'verseName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 8502944586431456524),
            name: 'bookName',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 1612273717797023081),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        7841013140937259992,
        2432895144899163143,
        824526277244711448
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Verse: EntityDefinition<Verse>(
        model: _entities[0],
        toOneRelations: (Verse object) => [],
        toManyRelations: (Verse object) => {},
        getId: (Verse object) => object.absoluteVerse,
        setId: (Verse object, int id) {
          object.absoluteVerse = id;
        },
        objectToFB: (Verse object, fb.Builder fbb) {
          final chapterNameOffset = fbb.writeString(object.chapterName);
          final textOffset = fbb.writeString(object.text);
          final verseNameOffset = fbb.writeString(object.verseName);
          final bookNameOffset = fbb.writeString(object.bookName);
          fbb.startTable(12);
          fbb.addInt64(0, object.absoluteVerse);
          fbb.addInt64(1, object.absoluteChapter);
          fbb.addInt64(3, object.verse);
          fbb.addOffset(5, chapterNameOffset);
          fbb.addOffset(7, textOffset);
          fbb.addInt64(8, object.chapter);
          fbb.addOffset(9, verseNameOffset);
          fbb.addOffset(10, bookNameOffset);
          fbb.finish(fbb.endTable());
          return object.absoluteVerse;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final bookNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 24, '');
          final chapterNameParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, '');
          final verseNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 22, '');
          final textParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final chapterParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          final verseParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final absoluteChapterParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final absoluteVerseParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final object = Verse(
              bookNameParam,
              chapterNameParam,
              verseNameParam,
              textParam,
              chapterParam,
              verseParam,
              absoluteChapterParam,
              absoluteVerseParam);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Verse] entity fields to define ObjectBox queries.
class Verse_ {
  /// see [Verse.absoluteVerse]
  static final absoluteVerse =
      QueryIntegerProperty<Verse>(_entities[0].properties[0]);

  /// see [Verse.absoluteChapter]
  static final absoluteChapter =
      QueryIntegerProperty<Verse>(_entities[0].properties[1]);

  /// see [Verse.verse]
  static final verse = QueryIntegerProperty<Verse>(_entities[0].properties[2]);

  /// see [Verse.chapterName]
  static final chapterName =
      QueryStringProperty<Verse>(_entities[0].properties[3]);

  /// see [Verse.text]
  static final text = QueryStringProperty<Verse>(_entities[0].properties[4]);

  /// see [Verse.chapter]
  static final chapter =
      QueryIntegerProperty<Verse>(_entities[0].properties[5]);

  /// see [Verse.verseName]
  static final verseName =
      QueryStringProperty<Verse>(_entities[0].properties[6]);

  /// see [Verse.bookName]
  static final bookName =
      QueryStringProperty<Verse>(_entities[0].properties[7]);
}
