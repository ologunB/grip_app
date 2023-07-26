import '../widgets/hex_text.dart';
import 'post_details.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({super.key});

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
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
          SizedBox(height: 36.h),
          Row(children: [item(0), item(1), item(2)]),
          Expanded(
              child: PageView(
            controller: controller,
            onPageChanged: (a) {
              currentIndex = a;
              setState(() {});
            },
            children: [body(), body(), body()],
          )),
          SizedBox(height: 16.h),
        ],
      ),
    );
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

  PageController controller = PageController();
  Widget body() {
    double width = (MediaQuery.of(context).size.width - 55.h) / 3;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 8.h),
      children: [
        Wrap(
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
        )
      ],
    );
  }
}
