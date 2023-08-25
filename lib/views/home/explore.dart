import '../../core/models/post_model.dart';
import '../../core/vms/post_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'post_details.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      onModelReady: (a) => a.getPosts(),
      builder: (_, PostViewModel model, __) => RefreshIndicator(
        onRefresh: () async {
          return model.getPosts();
        },
        color: AppColors.primary,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            titleSpacing: 20.h,
            centerTitle: false,
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
          ),
          body: model.busy
              ? model.posts != null
                  ? ListView(
                      padding: EdgeInsets.all(25.h),
                      children: [
                        StaggeredGrid.count(
                          crossAxisCount: model.posts!.length,
                          mainAxisSpacing: 6.h,
                          crossAxisSpacing: 6.h,
                          children: model.posts!
                              .map((e) => ExploreItem(post: e))
                              .toList(),
                        ),
                      ],
                    )
                  : Container(
                      height: 200.h,
                      alignment: Alignment.center,
                      child: const HexProgress(text: 'Getting posts'),
                    )
              : model.posts == null
                  ? Container(
                      height: 200.h,
                      alignment: Alignment.center,
                      child:
                          const HexError(text: 'Error occurred getting posts'),
                    )
                  : ListView(
                      padding: EdgeInsets.all(25.h),
                      children: [
                        StaggeredGrid.count(
                          crossAxisCount: model.posts!.length,
                          mainAxisSpacing: 6.h,
                          crossAxisSpacing: 6.h,
                          children: model.posts!
                              .map((e) => ExploreItem(post: e))
                              .toList(),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class ExploreItem extends StatelessWidget {
  const ExploreItem({super.key, required this.post});

  final Post post;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, PostDetailScreen(post: post));
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.h),
            child: Container(
              constraints: BoxConstraints(maxWidth: 400.h, minHeight: 200.h),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xff280E40)],
                  stops: [0.0, 1.0],
                ).createShader(bounds),
                blendMode: BlendMode.srcATop,
                child: CachedNetworkImage(
                  imageUrl: post.coverImage ?? 'm',
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Image.asset(
                    'placeholder'.png,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (_, __, ___) => Image.asset(
                    'placeholder'.png,
                    fit: BoxFit.cover,
                  ),
                ),
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
                        child: UserImage(
                          imageUrl: post.user?.image,
                          size: 39.h,
                          radius: 39.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.h),
                    HexText(
                      '${post.user?.username}',
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
