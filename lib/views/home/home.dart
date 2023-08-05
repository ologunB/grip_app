import '../widgets/hex_text.dart';
import 'notification.dart';
import 'post_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.white,
        titleSpacing: 25.h,
        title: CupertinoTextField(
          prefix: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Image.asset(
                  'search'.png,
                  height: 24.h,
                  color: const Color(0xffE0E0E0),
                ),
              ),
            ],
          ),
          placeholder: 'Search',
          placeholderStyle: TextStyle(
            fontFamily: 'Nova',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffE0E0E0),
          ),
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.h),
            border: Border.all(color: const Color(0xffE0E0E0)),
          ),
          maxLines: 3,
          minLines: 1,
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      push(context, const NotificationScreen());
                    },
                    borderRadius: BorderRadius.circular(50.h),
                    child: Image.asset('h1'.png, height: 44.h),
                  ),
                  SizedBox(width: 25.h),
                ],
              )
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 5.h),
          Row(
            children: [
              SizedBox(width: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: HexText(
                  'Recent Posts',
                  fontSize: 20.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: HexText(
                  'Recommended',
                  fontSize: 20.sp,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4.h,
            crossAxisSpacing: 4.h,
            children: [1, 1, 1, 1, 1, 1].map((e) => const HomeItem()).toList(),
          ),
        ],
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, const PostDetailScreen());
      },
      child: IntrinsicHeight(
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xff280E40)],
                stops: [0.0, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.srcATop,
              child: Image.asset('video'.png),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HexText(
                    'In the beginning',
                    fontSize: 12.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 11.h,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.h),
                          child: Image.asset(
                            'placeholder'.png,
                            height: 10.h,
                            width: 10.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 7.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HexText(
                            'Anna Devine',
                            fontSize: 10.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 1.h),
                          HexText(
                            '12 Hours Ago',
                            fontSize: 8.sp,
                            color: AppColors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
