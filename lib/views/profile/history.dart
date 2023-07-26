import '../widgets/hex_text.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: HexText(
          'History',
          fontSize: 16.sp,
          color: AppColors.black,
          fontWeight: FontWeight.normal,
        ),
        elevation: 0,
      ),
      body: ListView.separated(
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
        itemCount: 14,
        itemBuilder: (c, i) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.h),
            child: Row(
              children: [
                Image.asset('placeholder'.png, height: 24.h),
                SizedBox(width: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HexText(
                      'Ola Ajayi',
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8.h),
                    HexText(
                      'J.P at the diner',
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(width: 8.h),
                HexText(
                  '1 year ago',
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
