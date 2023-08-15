import 'package:hexcelon/core/apis/base_api.dart';

import '../../core/models/post_model.dart';
import '../home/post_details.dart';
import '../widgets/hex_text.dart';

class MyPostDetailScreen extends StatefulWidget {
  const MyPostDetailScreen({super.key, required this.post});

  final Post post;
  @override
  State<MyPostDetailScreen> createState() => _MyPostDetailScreenState();
}

class _MyPostDetailScreenState extends State<MyPostDetailScreen> {
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
          '@${AppCache.getUser()?.user?.username}',
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
          Expanded(child: PostDetailScreen(post: widget.post))
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
