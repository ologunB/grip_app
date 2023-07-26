import '../widgets/hex_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool empty = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      empty = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        elevation: 0,
        centerTitle: true,
        title: HexText(
          'Notifications',
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: empty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('empty'.png, height: 120.h),
                Row(children: [SizedBox(height: 79.h)]),
                HexText(
                  'No Notification',
                  fontSize: 28.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w900,
                  align: TextAlign.center,
                ),
                SizedBox(height: 15.h),
                HexText(
                  'You do not have any notification\nat this time',
                  fontSize: 16.sp,
                  color: AppColors.black,
                  align: TextAlign.center,
                ),
                SizedBox(height: 75.h),
              ],
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              children: [
                SizedBox(height: 30.h),
                HexText(
                  'Today',
                  fontSize: 16.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 19.h),
                ListView.separated(
                  separatorBuilder: (_, __) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Divider(
                      height: 0.h,
                      thickness: 1.h,
                      color: const Color(0xffE6E6E6),
                    ),
                  ),
                  itemCount: 4,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 30.h,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.h),
                            child: Image.asset(
                              'placeholder'.png,
                              height: 59.h,
                              width: 59.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 19.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HexText(
                              'Pastor Iren uploaded a story',
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 5.h),
                            HexText(
                              '2 Mins ago',
                              fontSize: 14.sp,
                              color: AppColors.black,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }
}
