import '../bible/one_version.dart';
import '../widgets/grip_divider.dart';
import '../widgets/hex_text.dart';
import 'verses.dart';

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
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.bgColor,
        elevation: 0,
        centerTitle: true,
        title: HexText(
          'Bible',
          fontSize: 20.sp,
          color: context.textColor,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: context.primary),
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
                    String name = d.keys.toList()[i];

                    return ChapterItem(
                      name: name,
                      value: d.values.toList()[i],
                      onTap: () {
                        push(
                          context,
                          VersesScreen(
                            type: 'chapter',
                            value: d.values.toList()[i],
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
                            value: d.values.toList()[i],
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
