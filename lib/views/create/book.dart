import 'package:hexcelon/views/create/verses.dart';

import '../bible/one_version.dart';
import '../widgets/grip_divider.dart';
import '../widgets/hex_text.dart';

class ChooseBookScreen extends StatefulWidget {
  const ChooseBookScreen({super.key});

  @override
  State<ChooseBookScreen> createState() => _ChooseBookScreenState();
}

class _ChooseBookScreenState extends State<ChooseBookScreen> {
  PageController controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: HexText(
          'Bible',
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
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
                  separatorBuilder: (_, __) => const GripDivider(),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: Utils.splitBooks().first.length,
                  itemBuilder: (c, i) {
                    Map d = Utils.splitBooks().first;
                    String name = d.keys.toList()[i];
                    return ChapterItem(
                      name: name,
                      value: d.values.toList()[i],
                      onTap: () {
                        push(
                          context,
                          VersesScreen(
                            type: 'chapter',
                            data: [name],
                            popNumber: 3,
                          ),
                        );
                      },
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
                    String name = d.keys.toList()[i];
                    return ChapterItem(
                      name: name,
                      value: d.values.toList()[i],
                      onTap: () {
                        push(
                          context,
                          VersesScreen(
                            type: 'chapter',
                            data: [name],
                            popNumber: 3,
                          ),
                        );
                      },
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
