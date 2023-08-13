import 'package:collection/collection.dart';
import 'package:hexcelon/core/apis/base_api.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../core/storage/model.dart';
import '../widgets/hex_text.dart';
import 'one_version.dart';
import 'search.dart';

class VersesScreen extends StatefulWidget {
  const VersesScreen({super.key, required this.chapter, required this.book});

  final int chapter;
  final String book;
  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  late String book;
  late int chapter, prevChapter, nextChapter;
  List<Verse> verses = [];
  final ItemScrollController itemScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    book = widget.book;
    chapter = widget.chapter;
    getVerses();

    Future.delayed(const Duration(milliseconds: 1500), () {
      itemPositionsListener.itemPositions.addListener(_positionListener);
    });
  }

  String? oldChapter, currentChapter;

  _positionListener() {
    List<ItemPosition> li = itemPositionsListener.itemPositions.value.toList();
    li.sort((a, b) => a.index.compareTo(b.index));
    if (li.firstWhereOrNull((e) => e.index == 10) != null) {
      List<Verse> data = objectbox.get2ChaptersBefore(prevChapter);
      if (data.isNotEmpty) {
        print("Close to top, first chapter is ${data.first.chapterName}");
        prevChapter = prevChapter - 2;
        verses.addAll(data);
        verses = verses.toSet().toList();
        verses.sort((a, b) => a.absoluteVerse.compareTo(b.absoluteVerse));
        itemScrollController.jumpTo(index: data.length + li.first.index);
        setState(() {});
      }
    }

    if (li.firstWhereOrNull((e) => e.index == verses.length - 10) != null) {
      List<Verse> data = objectbox.get2ChaptersAfter(nextChapter);
      if (data.isNotEmpty) {
        print("Close to bottom, last chapter is ${data.last.chapterName}");
        nextChapter = nextChapter + 2;
        verses.addAll(data);
        verses = verses.toSet().toList();
        verses.sort((a, b) => a.absoluteVerse.compareTo(b.absoluteVerse));
        setState(() {});
      }
    }

    li.sort((a, b) => a.index.compareTo(b.index));
    oldChapter = verses[li.first.index].chapterName;
    if (oldChapter != currentChapter) {
      currentChapter = oldChapter;
      setState(() {});
    }
  }

  getVerses() {
    Verse firstVerse = objectbox.getOneVerse(book, chapter);
    prevChapter = firstVerse.absoluteChapter - 2;
    nextChapter = firstVerse.absoluteChapter + 2;
    verses = objectbox.get2ChaptersBeforeAndAfter(firstVerse.absoluteChapter);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemScrollController.jumpTo(
        index: verses
            .indexWhere((e) => e.absoluteVerse == firstVerse.absoluteVerse),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var groupedEntities = groupBy(verses, (Verse e) => e.chapter);

    groupedEntities = Map.fromEntries(
      groupedEntities.entries.toList()
        ..sort((e1, e2) => e1.key.compareTo(e2.key)),
    );
    List<String> a = [];
    groupedEntities.forEach((chapterId, entities) {
      a.add('${entities.first.chapterName} len: ${entities.length}');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(0, 50.h),
        child: SafeArea(
          child: Row(
            children: [
              SizedBox(width: 25.h),
              IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffEAEAEA),
                    borderRadius: BorderRadius.circular(40.h),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          dynamic a = await showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50.h),
                                topLeft: Radius.circular(50.h),
                              ),
                            ),
                            builder: (c) {
                              return SelectChapterDialog(name: book);
                            },
                          );
                          if (a != null) {
                            book = a.first;
                            chapter = a.last;
                            setState(() {});
                            getVerses();
                          }
                        },
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.h),
                          bottomLeft: Radius.circular(30.h),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HexText(
                                book,
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(width: 10.h),
                              Image.asset(
                                'down'.png,
                                height: 32.h,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 0, thickness: 0),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.h),
                          bottomLeft: Radius.circular(30.h),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: HexText(
                            'Books',
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'aa'.png,
                  height: 32.h,
                ),
              ),
              SizedBox(width: 24.h),
              InkWell(
                onTap: () {
                  push(context, const SearchPage(), true);
                },
                child: Image.asset(
                  'search'.png,
                  height: 32.h,
                  color: AppColors.black,
                ),
              ),
              SizedBox(width: 25.h),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ScrollablePositionedList.separated(
            itemCount: verses.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            itemBuilder: (context, index) {
              Verse element = verses[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (element.verse == 1) header(element.chapterName),
                  HexText(
                    ' ${element.verse}. ${element.text}',
                    fontSize: 16.sp,
                    color: Colors.black,
                    key: ValueKey(element.absoluteVerse),
                    fontWeight: FontWeight.w400,
                  )
                ],
              );
            },
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          ),
          if (currentChapter != null) header(currentChapter!)
        ],
      ),
    );
  }

  Widget header(String a) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: HexText(
            a,
            fontSize: 16.sp,
            color: Colors.black,
            align: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SelectChapterDialog extends StatefulWidget {
  const SelectChapterDialog({super.key, required this.name});

  final String name;
  @override
  State<SelectChapterDialog> createState() => _SelectChapterDialogState();
}

class _SelectChapterDialogState extends State<SelectChapterDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .9),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: HexText(
                    'Select Bible Chapter',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.center,
                    color: AppColors.black,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('close'.png, height: 24.h, width: 24.h),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.h),
          Expanded(
            child: ScrollablePositionedList.separated(
              shrinkWrap: true,
              initialScrollIndex:
                  Utils.allBooks.keys.toList().indexOf(widget.name),
              initialAlignment: 0.1,
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (_, __) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Divider(
                  height: 0.h,
                  thickness: 1.h,
                  color: const Color(0xffE6E6E6),
                ),
              ),
              itemCount: 66,
              itemBuilder: (c, i) {
                Map d = Utils.allBooks;
                return ChapterItem(
                  key: ValueKey(i),
                  name: d.keys.toList()[i],
                  value: d.values.toList()[i],
                  popWhenDone: true,
                  presentValue: d.keys.toList().indexOf(widget.name) == i,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
