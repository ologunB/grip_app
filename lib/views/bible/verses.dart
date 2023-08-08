import 'package:scroll_to_index/scroll_to_index.dart';

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
  late int chapter;

  @override
  void initState() {
    book = widget.book;
    chapter = widget.chapter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                children: [
                  HexText(
                    'Chapter 1',
                    fontSize: 16.sp,
                    color: Colors.black,
                    align: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 16.h),
                  HexText(
                    '''   1. Lorem ipsum dolor sit amet consectetur. Cras mauris enim vulputate sapien vitae. Viverra nulla scelerisque consectetur sed quam massa non eget. Orci faucibus viverra tristique pellentesque feugiat lorem. 

   2. Mauris odio scelerisque lacus nunc malesuada.
Nullam sapien neque in habitasse ante eget. Consequat massa consequat faucibus nulla in amet vel. Suscipit feugiat montes pellentesque cras turpis. 

   3. Pellentesque et quisque lacus justo tortor sapien. Eu platea a faucibus vivamus eu nulla metus diam.
Vel eu amet volutpat posuere tempor urna accumsan. Ultrices ac amet urna vel neque faucibus rutrum viverra ipsum. 

   4. Mi eu est varius commodo gravida iaculis nunc. Adipiscing lacus mauris facilisis facilisi eget quisque eu. Risus amet amet tortor sed leo facilisis. Eu netus eu sed risus tortor. Neque posuere a porttitor viverra.''',
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ],
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
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 60, 0, MediaQuery.of(context).padding.bottom),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.scrollToIndex(
        Utils.allBooks().keys.toList().indexOf(widget.name),
        preferPosition: AutoScrollPosition.begin,
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
            child: ListView.separated(
              shrinkWrap: true,
              controller: controller,
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
                Map d = Utils.allBooks();
                return AutoScrollTag(
                  key: ValueKey(i),
                  controller: controller,
                  index: i,
                  child: ChapterItem(
                    name: d.keys.toList()[i],
                    value: d.values.toList()[i],
                    popWhenDone: true,
                    presentValue: d.keys.toList().indexOf(widget.name) == i,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
