import '../widgets/hex_text.dart';
import 'chat_room.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.secondary,
        child: Image.asset(
          'add'.png,
          height: 24.h,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: HexText(
          'Messages',
          fontSize: 20.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
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
        itemCount: 4,
        padding: EdgeInsets.only(top: 5.h),
        itemBuilder: (c, i) {
          return InkWell(
            onTap: () {
              push(context, const ChatRoomScreen());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.h,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.h),
                      child: Image.asset(
                        'placeholder'.png,
                        height: 55.h,
                        width: 55.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            HexText(
                              'Zaire Saris',
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            const Spacer(),
                            HexText(
                              '35 min ago',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff939497),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            HexText(
                              'Lorem ipsum dolor sit amet, consectetur ...',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff939497),
                            ),
                            const Spacer(),
                            SizedBox(width: 8.h),
                            Container(
                              height: 24.h,
                              alignment: Alignment.center,
                              width: 24.h,
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(30.h),
                              ),
                              child: HexText(
                                '1',
                                fontSize: 12.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
