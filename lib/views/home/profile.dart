import '../../core/models/login_model.dart';
import '../../core/vms/auth_vm.dart';
import '../../core/vms/post_vm.dart';
import '../profile/creator_profile.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key, required this.user});

  final UserModel user;
  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  PageController pageController = PageController();

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    user = widget.user;
    super.initState();
  }

  late UserModel user;

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      builder: (_, AuthViewModel aModel, __) => BaseView<PostViewModel>(
        onModelReady: (a) => a.getPosts(),
        builder: (_, PostViewModel pModel, __) => Material(
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              transitionBetweenRoutes: false,
              backgroundColor: Colors.white,
              border: Border.all(color: Colors.white),
              leading: const BackButton(color: AppColors.primary),
            ),
            backgroundColor: Colors.white,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverList.list(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60.h),
                            child: UserImage(
                              imageUrl: user.image,
                              size: 107.h,
                              radius: 107.h,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          HexText(
                            '${user.username}',
                            fontSize: 18.sp,
                            align: TextAlign.center,
                            color: AppColors.black,
                            fontWeight: FontWeight.w800,
                          ),
                          SizedBox(height: 4.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 38.h),
                            child: HexText(
                              '${user.categories?.map((e) => e.name).toList().join(', ')}',
                              fontSize: 16.sp,
                              align: TextAlign.center,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 18.h),
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
                                    SizedBox(
                                      height: 25.h,
                                      child: pModel.busy
                                          ? HexProgress(size: 14.sp)
                                          : HexText(
                                              '${pModel.posts?.length ?? 0}',
                                              fontSize: 16.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w800,
                                            ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.h),
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
                                      '${user.followersCount ?? 0}',
                                      fontSize: 16.sp,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.h),
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
                                      '${user.followingCount ?? 0}',
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
                                  if (selected) {
                                    aModel.unfollow(user.id);
                                  } else {
                                    aModel.follow(user.id);
                                  }
                                  selected = !selected;
                                  setState(() {});
                                },
                                borderRadius: BorderRadius.circular(15.h),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50.h, vertical: 13.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h),
                                    border: Border.all(
                                      width: 1.h,
                                      color: AppColors.black,
                                    ),
                                    color: selected
                                        ? Colors.transparent
                                        : AppColors.black,
                                  ),
                                  child: HexText(
                                    selected ? 'Following' : 'Follow',
                                    fontSize: 12.sp,
                                    color: !selected
                                        ? Colors.white
                                        : AppColors.black,
                                    align: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    )
                  ],
                ),
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  leadingWidth: 0,
                  toolbarHeight: 0,
                  expandedHeight: 40,
                  collapsedHeight: 40,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  flexibleSpace: TabBar(
                    padding: EdgeInsets.zero,
                    controller: controller,
                    dividerColor: CupertinoColors.systemGrey5,
                    indicatorColor: AppColors.primary,
                    unselectedLabelColor: CupertinoColors.systemGrey,
                    tabs: [item(0), item(1), item(2)],
                  ),
                )
              ],
              body: pModel.busy
                  ? Container(
                      height: 200.h,
                      alignment: Alignment.center,
                      child: const HexProgress(),
                    )
                  : pModel.posts == null
                      ? Container(
                          height: 200.h,
                          alignment: Alignment.center,
                          child: HexText(
                            'Error occurred getting posts',
                            color: AppColors.red,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : PageView(
                          onPageChanged: (a) {
                            controller.index = a;
                            setState(() {});
                          },
                          controller: pageController,
                          children: [
                            ImageVideoAudioPV(
                                userPosts: pModel.posts, index: 0),
                            ImageVideoAudioPV(
                                userPosts: pModel.posts, index: 1),
                            ImageVideoAudioPV(
                                userPosts: pModel.posts, index: 2),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }

  Widget item(int i) {
    return InkWell(
      onTap: () {
        pageController.jumpToPage(i);
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Image.asset(
          'm$i${i == controller.index ? 1 : 0}'.png,
          height: 24.h,
          width: 24.h,
        ),
      ),
    );
  }

  bool selected = false;
}
