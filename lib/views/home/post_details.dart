import 'package:share_plus/share_plus.dart';

import '../widgets/hex_text.dart';
import 'profile.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      body: Stack(
        children: [
          Image.asset(
            'video'.png,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.h, right: 25.h, bottom: 50.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          push(context, const OtherProfileScreen());
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.h,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40.h),
                                child: Image.asset(
                                  'placeholder'.png,
                                  height: 58.h,
                                  width: 58.h,
                                ),
                              ),
                            ),
                            SizedBox(width: 9.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HexText(
                                  'Anna Devine',
                                  fontSize: 20.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 1.h),
                                HexText(
                                  '12 Hours Ago',
                                  fontSize: 15.sp,
                                  color: AppColors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 27.h),
                      HexText(
                        'J.P at the dinner',
                        fontSize: 15.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      SizedBox(height: 22.h),
                      Image.asset('slide'.png)
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 34.h),
                      child: InkWell(
                        onTap: Navigator.of(context).pop,
                        child: Image.asset(
                          'close'.png,
                          height: 32.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ...[1, 2, 3, 4, 5]
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: InkWell(
                              onTap: () {
                                if (e == 1) {
                                  Share.share('This is a post');
                                } else if (e == 2) {
                                  showModalBottomSheet(
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
                                      return const CommentsDialog();
                                    },
                                  );
                                } else if (e == 3) {
                                  liked = !liked;
                                  setState(() {});
                                } else if (e == 4) {
                                  showModalBottomSheet(
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
                                      return const DevotionalDialog();
                                    },
                                  );
                                } else {}
                              },
                              child: Image.asset(
                                e == 3 && liked ? 'like'.png : 'v$e'.png,
                                height: 32.h,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    SizedBox(height: 20.h),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool liked = false;
}

class CommentsDialog extends StatelessWidget {
  const CommentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .8),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.h),
        physics: const ClampingScrollPhysics(),
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: HexText(
                  'Comments',
                  fontSize: 14.sp,
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
                  child: Image.asset(
                    'close'.png,
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          2 == 3
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: HexText(
                    'There are no comments at the moment. Be the\nfirst to comment',
                    fontSize: 14.sp,
                    align: TextAlign.center,
                    color: AppColors.black,
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(height: 25.h),
                  itemCount: 4,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 25.h,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.h),
                            child: Image.asset(
                              'placeholder'.png,
                              height: 48.h,
                              width: 48.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 9.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HexText(
                              'Aaron',
                              fontSize: 16.sp,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 3.h),
                            HexText(
                              'God is good',
                              fontSize: 12.sp,
                              color: AppColors.black,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
          SizedBox(height: 25.h),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  padding: EdgeInsets.all(15.h),
                  placeholderStyle: GoogleFonts.nunito(
                      fontSize: 14.sp, color: AppColors.grey),
                  placeholder: 'Leave a comment',
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.h,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.h),
              Image.asset('send'.png, height: 50.h)
            ],
          )
        ],
      ),
    );
  }
}

class DevotionalDialog extends StatelessWidget {
  const DevotionalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.h),
      physics: const ClampingScrollPhysics(),
      children: [
        Stack(
          children: [
            HexText(
              'Study Devotional Message',
              fontSize: 14.sp,
              align: TextAlign.center,
              color: AppColors.black,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'close'.png,
                  height: 24.h,
                  width: 24.h,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        HexText(
          'Warm Coffee',
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 30.h),
        HexText(
          '1 Kings 9:10',
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 12.h),
        HexText(
          'And it came to past at the end of twenty years, when Solomon had built the two houses, the house of the Lord, and the King’s house',
          fontSize: 14.sp,
          color: AppColors.black,
        ),
        SizedBox(height: 150.h),
        HexButton(
          'Dismiss',
          buttonColor: AppColors.primary,
          height: 55,
          safeArea: false,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.white,
          borderColor: AppColors.primary,
          borderRadius: 10.h,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
