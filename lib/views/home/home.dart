import 'package:hexcelon/core/apis/base_api.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/post_model.dart';
import '../../core/vms/post_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'notification.dart';
import 'post_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.white,
        titleSpacing: 25.h,
        title: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: CupertinoTextField(
            prefix: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Image.asset(
                    'search'.png,
                    height: 16.h,
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
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Row(
            children: [
              SizedBox(width: 15.h),
              TextButton(
                onPressed: () {
                  setState(() => index = 0);
                },
                child: HexText(
                  'Recent Posts',
                  fontSize: 20.sp,
                  color: index == 0 ? Colors.black : AppColors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 10.h),
              TextButton(
                onPressed: () {
                  setState(() => index = 1);
                },
                child: HexText(
                  'Recommended',
                  fontSize: 20.sp,
                  color: index == 1 ? Colors.black : AppColors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: index,
              children: [
                BaseView<PostViewModel>(
                  onModelReady: (a) => a.getPosts(
                      type: 'recent/${AppCache.getUser()?.user?.id}'),
                  builder: (_, PostViewModel model, __) => RefreshIndicator(
                    onRefresh: () async {
                      return model.getPosts(
                          type: 'recent/${AppCache.getUser()?.user?.id}');
                    },
                    color: AppColors.primary,
                    child: body(model),
                  ),
                ),
                BaseView<PostViewModel>(
                  onModelReady: (a) => a.getPosts(type: 'recommended'),
                  builder: (_, PostViewModel model, __) => RefreshIndicator(
                    onRefresh: () async {
                      return model.getPosts(type: 'recommended');
                    },
                    color: AppColors.primary,
                    child: body(model),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget body(PostViewModel model) {
    return ListView(
      children: [
        model.busy
            ? model.posts != null
                ? StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.h,
                    crossAxisSpacing: 4.h,
                    children:
                        model.posts!.map((e) => HomeItem(post: e)).toList(),
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
                    child: const HexError(text: 'Error occurred getting posts'),
                  )
                : StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.h,
                    crossAxisSpacing: 4.h,
                    children:
                        model.posts!.map((e) => HomeItem(post: e)).toList(),
                  )
      ],
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(context, PostDetailScreen(post: post));
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
              child: Container(
                constraints: BoxConstraints(maxWidth: 400.h, minHeight: 250.h),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  HexText(
                    '${post.title}',
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
                          child: UserImage(
                            imageUrl: post.user?.image,
                            size: 10.h,
                            radius: 39.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 7.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HexText(
                            '${post.user?.username}',
                            fontSize: 10.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 1.h),
                          HexText(
                            timeago.format(DateTime.parse(post.createdAt!)),
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
