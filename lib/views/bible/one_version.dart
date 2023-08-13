import 'package:flutter/scheduler.dart';
import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/profile/all_versions.dart';

import '../widgets/hex_text.dart';
import 'passage.dart';

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
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (Utils.splitBooks().first.isEmpty) {
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 500));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
                size: 26.h,
              )
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.symmetric(horizontal: 25.h),
            decoration: BoxDecoration(
              color: const Color(0xffAEAEAE).withOpacity(.1),
              borderRadius: BorderRadius.circular(16.h),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.jumpToPage(0);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: HexText(
                        'Old Testament',
                        fontSize: 12.sp,
                        color: index == 1 ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.jumpToPage(1);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      decoration: BoxDecoration(
                        color: index == 1 ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: HexText(
                        'New Testament',
                        fontSize: 12.sp,
                        color: index == 0 ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
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
                  separatorBuilder: (_, __) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: Divider(
                      height: 0.h,
                      thickness: 1.h,
                      color: const Color(0xffE6E6E6),
                    ),
                  ),
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
                  separatorBuilder: (_, __) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: Divider(
                      height: 0.h,
                      thickness: 1.h,
                      color: const Color(0xffE6E6E6),
                    ),
                  ),
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
  });
  final String name;
  final List<int> value;
  final bool popWhenDone;
  final bool presentValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
          context,
          PassageScreen(
            value: value.length,
            name: name,
            popWhenDone: popWhenDone,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.h),
        color: presentValue ? AppColors.primary.withOpacity(.2) : null,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HexText(
                  name,
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8.h),
                HexText(
                  '${value.length} Chapters',
                  fontSize: 14.sp,
                  color: AppColors.black,
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              'go'.png,
              height: 24.h,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
