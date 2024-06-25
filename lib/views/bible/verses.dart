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
  int? verse;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  String? oldChapter, currentChapter;

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

  _positionListener() {
    List<ItemPosition> li = itemPositionsListener.itemPositions.value.toList();
    li.sort((a, b) => a.index.compareTo(b.index));
    if (li.firstWhereOrNull((e) => e.index == 10) != null) {
      List<Verse> data = objectbox.get2ChaptersBefore(prevChapter);
      if (data.isNotEmpty) {
        debugPrint("Close to top, first chapter is ${data.first.chapterName}");
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
        debugPrint("Close to bottom, last chapter is ${data.last.chapterName}");
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
    Verse firstVerse = objectbox.getOneVerse(book, chapter, verse: verse);
    prevChapter = firstVerse.absoluteChapter - 2;
    nextChapter = firstVerse.absoluteChapter + 2;
    verses = objectbox.get2ChaptersBeforeAndAfter(firstVerse.absoluteChapter);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      int index =
          verses.indexWhere((e) => e.absoluteVerse == firstVerse.absoluteVerse);
      if (verse != null) {
        // if you select verse scroll up a little
        index = (index - 2).isNegative ? index : index - 2;
      }
      itemScrollController.jumpTo(index: index);
    });
  }

  String selectedText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: PreferredSize(
        preferredSize: Size(0, 70.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              children: [
                SizedBox(width: 25.h),
                IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.isLight
                          ? const Color(0xffEAEAEA)
                          : AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(40.h),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            dynamic a = await showModalBottomSheet(
                              backgroundColor: context.sheetBG,
                              context: context,
                              useRootNavigator: true,
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
                              verse = null;
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
                                  color: context.textColor,
                                  fontWeight: FontWeight.normal,
                                ),
                                SizedBox(width: 10.h),
                                Image.asset(
                                  'down'.png,
                                  height: 32.h,
                                  color: context.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const VerticalDivider(width: 0, thickness: 0),
                        Padding(
                          padding: EdgeInsets.all(10.h),
                          child: HexText(
                            'Books',
                            fontSize: 16.sp,
                            color: context.textColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    openFont = true;
                    setState(() {});
                  },
                  child: Image.asset(
                    'aa'.png,
                    height: 32.h,
                    color: context.textColor,
                  ),
                ),
                SizedBox(width: 24.h),
                InkWell(
                  onTap: () async {
                    dynamic a = await push(context, const SearchPage(), true);
                    if (a != null) {
                      book = a.first;
                      verse = a[1];
                      chapter = a.last;
                      setState(() {});
                      getVerses();
                    }
                  },
                  borderRadius: BorderRadius.circular(30.h),
                  child: Image.asset(
                    'search'.png,
                    height: 32.h,
                    color: context.textColor,
                  ),
                ),
                SizedBox(width: 25.h),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: () {
              openFont = false;
              setState(() {});
            },
            child: SelectionArea(
              onSelectionChanged: (value) {
                selectedText = value?.plainText ?? "";
              },
              contextMenuBuilder: (context, editableTextState) {
                final List<ContextMenuButtonItem> buttonItems =
                    editableTextState.contextMenuButtonItems;
                buttonItems.removeWhere(
                    (e) => e.type == ContextMenuButtonType.selectAll);
                buttonItems.insert(
                  0,
                  ContextMenuButtonItem(
                    label: 'Share Verse(s)',
                    onPressed: () {
                      editableTextState.hideToolbar();
                      Share.share(selectedText, subject: 'Bible Verse');
                    },
                  ),
                );
                return AdaptiveTextSelectionToolbar.buttonItems(
                  anchors: editableTextState.contextMenuAnchors,
                  buttonItems: buttonItems,
                );
              },
              child: ScrollablePositionedList.builder(
                itemCount: verses.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  Verse v = verses[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      if (v.verse == 1) header(v.chapterName),
                      AnimatedContainer(
                        padding: EdgeInsets.only(
                          top: v.verse == 1 ? 5.h : 0.h,
                          bottom: 5.h,
                          right: 25.h,
                          left: 25.h,
                        ),
                        duration: const Duration(seconds: 1),
                        color: (v.verse == verse && v.chapter == chapter)
                            ? AppColors.secondary.withOpacity(.2)
                            : null,
                        child: HexText(
                          '${v.verse}. ${v.text}',
                          key: ValueKey(v.absoluteVerse),
                          fontSize: bibleFontSize().sp,
                          color: context.textColor,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  );
                },
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
              ),
            ),
          ),
          if (currentChapter != null) header(currentChapter!),
          if (openFont)
            Container(
              color: context.bgColor,
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: AppCache.getBibleFont(),
                          activeColor: context.primary,
                          onChanged: (double value) {
                            setState(() {
                              AppCache.setBibleFont(value);
                            });
                          },
                        ),
                      ),
                      CloseButton(
                        color: AppColors.red,
                        onPressed: () {
                          openFont = false;
                          setState(() {});
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  bool openFont = false;

  double bibleFontSize() {
    double sliderValue = AppCache.getBibleFont();
    if (sliderValue <= 0.4) {
      return 10 + (sliderValue / 0.4) * 6;
    } else {
      return 16 + ((sliderValue - 0.4) / 0.6) * 8;
    }
  }

  Widget header(String a) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 3.h),
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
          decoration: BoxDecoration(
            color:
                context.isLight ? const Color(0xffEAEAEA) : AppColors.darkGrey,
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: HexText(
            a,
            fontSize: bibleFontSize().sp,
            color: context.textColor,
            align: TextAlign.center,
            fontWeight: FontWeight.w600,
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
                    color: context.textColor,
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
              itemCount: Utils.allBooks.length,
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
