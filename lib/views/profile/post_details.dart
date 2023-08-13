import '../home/post_details.dart';
import '../widgets/hex_text.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: HexText(
          '@Chinwo4Christ007',
          fontSize: 16.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          HexText(
            'My Posts',
            fontSize: 14.sp,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  'video'.png,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.h, vertical: 50.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Row(
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
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context, useRootNavigator: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50.h),
                                    topLeft: Radius.circular(50.h),
                                  ),
                                ),
                                builder: (c) {
                                  return const EditPostDialog();
                                },
                              );
                            },
                            child: Image.asset('v0'.png, height: 32.h),
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
                                          context: context, useRootNavigator: true,
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
                                          context: context, useRootNavigator: true,
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
          )
        ],
      ),
    );
  }

  bool liked = false;
}

class EditPostDialog extends StatelessWidget {
  const EditPostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.h),
      physics: const ClampingScrollPhysics(),
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: HexText(
                'Post',
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
        SizedBox(height: 50.h),
        HexButton(
          'Edit Post',
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
        SizedBox(height: 20.h),
        HexButton(
          'Delete Post',
          buttonColor: AppColors.white,
          height: 55,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.red,
          borderColor: AppColors.grey,
          borderRadius: 10.h,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
