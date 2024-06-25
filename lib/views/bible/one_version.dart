import 'package:flutter/scheduler.dart';
import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/profile/all_versions.dart';

import '../widgets/grip_divider.dart';
import '../widgets/hex_text.dart';
import 'passage.dart';
import 'verses.dart';

class OneVersionScreen extends StatefulWidget {
  const OneVersionScreen({super.key});

  @override
  State<OneVersionScreen> createState() => _OneVersionScreenState();
}

class _OneVersionScreenState extends State<OneVersionScreen> {
  PageController controller = PageController();
  int index = 0;

  @override
  void initState() {
    int checker = 0;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (checker < 5) {
        checker++;
        if (mounted) setState(() {});
        await Future.delayed(const Duration(milliseconds: 500));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.bgColor,
        elevation: 0,
        centerTitle: true,
        title: InkWell(
          onTap: () async {
            await push(context, const AllVersionScreen(), true);
            setState(() {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HexText(
                'Bible (${AppCache.getDefaultBible()?.toUpperCase()})',
                fontSize: 20.sp,
                color: context.textColor,
                fontWeight: FontWeight.w600,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.primary,
                size: 26.h,
              )
            ],
          ),
        ),
        iconTheme: IconThemeData(color: context.textColor),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.symmetric(horizontal: 25.h),
            decoration: BoxDecoration(
              color: context.primary.withOpacity(.3),
              borderRadius: BorderRadius.circular(16.h),
            ),
            child: Row(
              children: [0, 1]
                  .map(
                    (i) => Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.jumpToPage(i);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                            color: index == i
                                ? context.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.h),
                          ),
                          child: HexText(
                            '${i == 0 ? 'Old' : 'New'} Testament',
                            fontSize: 12.sp,
                            color: index == i
                                ? (context.isLight
                                    ? AppColors.white
                                    : AppColors.secondary)
                                : (context.isLight
                                    ? AppColors.secondary
                                    : AppColors.white),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (a) {
                index = a;
                setState(() {});
              },
              controller: controller,
              children: [
                ListView.separated(
                  separatorBuilder: (_, __) => const GripDivider(),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: Utils.splitBooks().first.length,
                  itemBuilder: (c, i) {
                    Map d = Utils.splitBooks().first;
                    return ChapterItem(
                      name: d.keys.toList()[i],
                      value: d.values.toList()[i],
                    );
                  },
                ),
                ListView.separated(
                  separatorBuilder: (_, __) => const GripDivider(),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: Utils.splitBooks().last.length,
                  itemBuilder: (c, i) {
                    Map d = Utils.splitBooks().last;
                    return ChapterItem(
                      name: d.keys.toList()[i],
                      value: d.values.toList()[i],
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChapterItem extends StatelessWidget {
  const ChapterItem({
    super.key,
    required this.name,
    required this.value,
    this.popWhenDone = false,
    this.presentValue = false,
    this.onTap,
  });
  final String name;
  final List<int> value;
  final bool popWhenDone;
  final bool presentValue;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else if (value.length == 1) {
          // just one chapter so just go to verses
          if (popWhenDone) {
            Navigator.pop(context, [name, 1]);
          } else {
            push(context, VersesScreen(book: name, chapter: 1));
          }
        } else {
          push(
            context,
            PassageScreen(
              value: value.length,
              name: name,
              popWhenDone: popWhenDone,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.h),
        color: presentValue ? AppColors.secondary.withOpacity(.2) : null,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HexText(
                  name,
                  style:
                      AppThemes.bibleTitle.copyWith(color: context.textColor),
                ),
                SizedBox(height: 8.h),
                HexText(
                  value.length == 1 ? '1 Chapter' : '${value.length} Chapters',
                  style: AppThemes.bibleVersionText
                      .copyWith(color: context.textColor),
                ),
              ],
            ),
            const Spacer(),
            Image.asset('go'.png, height: 24.h, color: context.primary)
          ],
        ),
      ),
    );
  }
}
