import '../widgets/hex_text.dart';
import 'post_details.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBG,
        titleSpacing: 20.h,
        centerTitle: false,
        title: CupertinoTextField(
          prefix: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Image.asset('search'.png, height: 24.h),
              ),
            ],
          ),
          placeholder: 'Search',
          placeholderStyle: TextStyle(
            fontFamily: 'Nova',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.h),
            border: Border.all(color: AppColors.primary.withOpacity(.4)),
          ),
          maxLines: 3,
          minLines: 1,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(25.h),
        children: [
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 6.h,
            crossAxisSpacing: 6.h,
            children: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
                .map((e) => const ExploreItem())
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ExploreItem extends StatelessWidget {
  const ExploreItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, const PostDetailScreen());
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.h),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xff280E40)],
                stops: [0.0, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.srcATop,
              child: Image.asset(
                'video'.png,
                height: 200.h,
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.h,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.h),
                        child: Image.asset(
                          'placeholder'.png,
                          height: 39.h,
                          width: 39.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.h),
                    HexText(
                      'Dayo Jesus',
                      fontSize: 14.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
