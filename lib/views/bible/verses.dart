import 'package:hexcelon/core/apis/base_api.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../core/storage/model.dart';
import '../widgets/grouped_list.dart';
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
  final double endReachedThreshold = 300.0;

  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 36.h, 0, MediaQuery.of(context).padding.bottom),
    );
    book = widget.book;
    chapter = widget.chapter;
    getVerses();
    controller.addListener(_onScroll);
  }

  getVerses() {
    Verse firstVerse = objectbox.getOneVerse(book, chapter);
    prevChapter = firstVerse.absoluteChapter - 2;
    nextChapter = firstVerse.absoluteChapter + 2;
    verses = objectbox.get2ChaptersBeforeAndAfter(firstVerse.absoluteChapter);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.scrollToIndex(
        firstVerse.absoluteVerse,
        preferPosition: AutoScrollPosition.begin,
        duration: const Duration(milliseconds: 1),
      );
    });
  }

  _onScroll() {
    if (controller.offset >=
            controller.position.maxScrollExtent - endReachedThreshold &&
        !controller.position.outOfRange) {
      print("Close to bottom");
      List<Verse> data = objectbox.get2ChaptersAfter(nextChapter);
      if (data.isNotEmpty) {
        nextChapter = nextChapter + 2;
        verses.addAll(data);
        verses = verses.toSet().toList();
        setState(() {});
      }
    }
    print(controller.offset);

    if (controller.offset <= endReachedThreshold &&
        !controller.position.outOfRange) {
      print("Close to top");
      List<Verse> data = objectbox.get2ChaptersBefore(prevChapter);
      if (data.isNotEmpty) {
        prevChapter = prevChapter - 2;
        verses.addAll(data);
        verses = verses.toSet().toList();
        setState(() {});
        double totalHeight = 0;

        for (var item in data) {
          totalHeight += estimateTextHeight(item.text);
        }
        controller.jumpTo(controller.offset + totalHeight);
        controller.animateTo(
          controller.offset + 1,
          duration: const Duration(milliseconds: 1),
          curve: Curves.linear,
        );
      }
    }
  }

  double estimateTextHeight(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Nova',
          fontWeight: FontWeight.w400,
        ),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: MediaQuery.of(context).size.width - 50.h);

    return textPainter.size.height + 10.h + 70.h;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
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
            SizedBox(height: 15.h),
            Expanded(
              child: GroupedListView<Verse, int>(
                key: const ValueKey('ListViewKey'),
                controller: controller,
                elements: verses,
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                groupBy: (element) => element.absoluteChapter,
                groupHeaderBuilder: (group) => Row(
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
                        group.chapterName,
                        fontSize: 16.sp,
                        color: Colors.black,
                        align: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                separator: SizedBox(height: 10.h),
                itemBuilder: (context, Verse element) {
                  return AutoScrollTag(
                    key: ValueKey(element.absoluteVerse),
                    controller: controller,
                    index: element.absoluteVerse,
                    child: HexText(
                      '${element.verse}. ${element.text}',
                      fontSize: 16.sp,
                      color: Colors.black,
                      key: ValueKey(element.absoluteVerse),
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
                itemComparator: (a, b) =>
                    a.absoluteVerse.compareTo(b.absoluteVerse),
                groupComparator: (a, b) => a.compareTo(b),
                useStickyGroupSeparators: true,
                floatingHeader: true,
                order: GroupedListOrder.ASC,
              ),
            )
          ],
        ),
      ),
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
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemScrollController.jumpTo(
        index: Utils.allBooks.keys.toList().indexOf(widget.name),
      );
    });
  }

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
              itemScrollController: itemScrollController,
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
