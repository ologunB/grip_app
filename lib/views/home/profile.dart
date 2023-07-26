import '../profile/post_details.dart';
import '../widgets/hex_text.dart';
import 'chat_room.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryBG,
        body: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset('cover'.png),
                          Positioned(
                            right: 0,
                            left: 0,
                            bottom: -57.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      radius: 57.h,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(73.h),
                                        child: Image.asset(
                                          'placeholder'.png,
                                          height: 107.h,
                                          width: 107.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SafeArea(
                              child: BackButton(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 62.h),
                      HexText(
                        'Roger Korsgaard',
                        fontSize: 18.sp,
                        align: TextAlign.center,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 33.h),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                HexText(
                                  'Post',
                                  fontSize: 16.sp,
                                  color: AppColors.grey200,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 8.h),
                                HexText(
                                  '100',
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.h),
                              child: VerticalDivider(
                                color: const Color(0xffA0A0A0),
                                width: 0,
                                thickness: 1.h,
                              ),
                            ),
                            Column(
                              children: [
                                HexText(
                                  'Followers',
                                  fontSize: 16.sp,
                                  color: AppColors.grey200,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 8.h),
                                HexText(
                                  '200k',
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.h),
                              child: VerticalDivider(
                                color: const Color(0xffA0A0A0),
                                width: 0,
                                thickness: 1.h,
                              ),
                            ),
                            Column(
                              children: [
                                HexText(
                                  'Following',
                                  fontSize: 16.sp,
                                  color: AppColors.grey200,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 8.h),
                                HexText(
                                  '200',
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 26.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              selected = !selected;
                              setState(() {});
                            },
                            borderRadius: BorderRadius.circular(15.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.h, vertical: 13.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.h),
                                border: Border.all(
                                  width: 1.h,
                                  color: AppColors.black,
                                ),
                                color: selected
                                    ? Colors.transparent
                                    : AppColors.primary,
                              ),
                              child: HexText(
                                selected ? 'Following' : 'Follow',
                                fontSize: 12.sp,
                                color:
                                    !selected ? Colors.white : AppColors.black,
                                align: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.h),
                          InkWell(
                            onTap: () {
                              push(context, const ChatRoomScreen());
                            },
                            borderRadius: BorderRadius.circular(15.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.h, vertical: 13.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.h),
                                border: Border.all(
                                  width: 1.h,
                                  color: AppColors.black,
                                ),
                                color: Colors.transparent,
                              ),
                              child: HexText(
                                'Message',
                                fontSize: 12.sp,
                                color: AppColors.black,
                                align: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(children: [item(0), item(1), item(2)]),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: viewportConstraints.maxHeight,
                    child: PageView(
                      controller: controller,
                      onPageChanged: (a) {
                        currentIndex = a;
                        setState(() {});
                      },
                      children: [body(), body(), body()],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget item(int i) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.jumpToPage(i);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Image.asset(
            'm$i${i == currentIndex ? 1 : 0}'.png,
            height: 24.h,
            width: 24.h,
          ),
        ),
      ),
    );
  }

  int currentIndex = 0;
  bool selected = false;
  PageController controller = PageController();
  Widget body() {
    double width = (MediaQuery.of(context).size.width - 55.h) / 3;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 8.h),
      child: Wrap(
        spacing: 2.h,
        runSpacing: 2.h,
        children: List.filled(40, 0)
            .map(
              (e) => InkWell(
                onTap: () {
                  push(context, const PostDetailScreen());
                },
                child: Image.asset(
                  'placeholder'.png,
                  height: width,
                  width: width,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
