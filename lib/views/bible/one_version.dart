import 'package:hexcelon/views/bible/verses.dart';

import '../widgets/hex_text.dart';

class OneVersionScreen extends StatefulWidget {
  const OneVersionScreen({super.key});

  @override
  State<OneVersionScreen> createState() => _OneVersionScreenState();
}

class _OneVersionScreenState extends State<OneVersionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  SizedBox(width: 25.h),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const BackButtonIcon(),
                  ),
                  SizedBox(width: 12.h),
                  Padding(
                    padding: EdgeInsets.only(right: 11.h),
                    child: HexText(
                      'Bible',
                      fontSize: 30.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String result) {},
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'kjv',
                        child: HexText(
                          'KJV',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'nlt',
                        child: HexText(
                          'NLT',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        color: AppColors.primary.withOpacity(.1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HexText(
                            'KJV',
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColors.primary,
                            size: 30.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                SizedBox(width: 25.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: HexText(
                    'Old Testament',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: HexText(
                    'New Testament',
                    fontSize: 20.sp,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => Divider(
                  height: 0.h,
                  thickness: 1.h,
                  color: const Color(0xffE6E6E6),
                ),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () {
                      push(context, const VersesScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 25.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HexText(
                                'Genesis',
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 8.h),
                              HexText(
                                '50 Chapters',
                                fontSize: 14.sp,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(width: 8.h),
                          Image.asset('go'.png, height: 24.h)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<int> selected = [];

  download(int i) {
    selected.add(i);
    setState(() {});
  }
}
