import 'package:hexcelon/core/apis/base_api.dart';

import '../../core/models/login_model.dart';
import '../../core/vms/auth_vm.dart';
import '../../core/vms/post_vm.dart';
import '../../core/vms/settings_vm.dart';
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
  bool selected = false;
  StreamSubscription? sSub;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    user = widget.user;
    selected = user.isFollow ?? false;

    if (settingsVM.currentUsers[user.id] != null) {
      user = settingsVM.currentUsers[user.id]!;
      selected = user.isFollow ?? false;
    }
    sSub = settingsVM.outUsers.listen((event) {
      if (settingsVM.currentPosts[user.id] != null) {
        user = settingsVM.currentUsers[user.id]!;
        selected = user.isFollow ?? false;
      }
    });

    super.initState();
  }

  late UserModel user;

  @override
  void dispose() {
    sSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = context.isLight ? AppColors.secondary : AppColors.grey;
    return BaseView<AuthViewModel>(
      builder: (_, AuthViewModel aModel, __) => BaseView<PostViewModel>(
        onModelReady: (a) => a.getPosts(type: 'recent/${widget.user.id}'),
        builder: (_, PostViewModel pModel, __) => Material(
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              transitionBetweenRoutes: false,
              backgroundColor: context.bgColor,
              border: Border.all(color: context.bgColor),
              leading: BackButton(color: context.primary),
            ),
            backgroundColor: context.bgColor,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverList.list(
                  children: [
                    Container(
                      color: context.bgColor,
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
                            color: context.textColor,
                            fontWeight: FontWeight.w800,
                          ),
                          SizedBox(height: 4.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 38.h),
                            child: HexText(
                              '${user.categories?.map((e) => '#${e.name?.toLowerCase()}').toList().join(' ')}',
                              fontSize: 16.sp,
                              align: TextAlign.center,
                              color: AppColors.grey2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 20.h),
                                Expanded(
                                  child: Column(
                                    children: [
                                      HexText(
                                        'Post',
                                        fontSize: 16.sp,
                                        color: context.textColor,
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
                                                color: context.primary,
                                                fontWeight: FontWeight.w800,
                                              ),
                                      ),
                                    ],
                                  ),
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      HexText(
                                        'Followers',
                                        fontSize: 16.sp,
                                        color: context.textColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(height: 8.h),
                                      HexText(
                                        '${user.followersCount ?? 0}',
                                        fontSize: 16.sp,
                                        color: context.primary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ],
                                  ),
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      HexText(
                                        'Following',
                                        fontSize: 16.sp,
                                        color: context.textColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(height: 8.h),
                                      HexText(
                                        '${user.followingCount ?? 0}',
                                        fontSize: 16.sp,
                                        color: context.primary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.h),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          if (AppCache.getUser()?.user?.id != user.id)
                            Padding(
                              padding: EdgeInsets.all(16.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (selected) {
                                        aModel.unfollow(user.id);
                                        selected = false;
                                      } else {
                                        aModel.follow(user.id);
                                        selected = true;
                                      }
                                      setState(() {});
                                    },
                                    borderRadius: BorderRadius.circular(15.h),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.h, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.h),
                                        border: Border.all(
                                            width: 1.h, color: color),
                                        color: selected
                                            ? AppColors.secondary
                                            : Colors.transparent,
                                      ),
                                      child: HexText(
                                        selected ? 'Following' : 'Follow',
                                        fontSize: 14.sp,
                                        color: selected ? Colors.white : color,
                                        align: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                  backgroundColor: context.bgColor,
                  flexibleSpace: TabBar(
                    padding: EdgeInsets.zero,
                    controller: controller,
                    dividerColor: CupertinoColors.systemGrey5,
                    indicatorColor: context.primary,
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
                          children: [0, 1, 2]
                              .map((i) =>
                                  ImageVideoAudioPV(model: pModel, index: i))
                              .toList(),
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
          color: i == controller.index ? context.primary : context.textColor,
        ),
      ),
    );
  }
}
