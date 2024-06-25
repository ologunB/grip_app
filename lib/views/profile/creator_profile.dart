import '../../core/models/post_model.dart';
import '../../core/storage/local_storage.dart';
import '../../core/vms/post_vm.dart';
import '../bible/search.dart';
import '../home/post_details.dart';
import '../profile/all_versions.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'bookmarks.dart';
import 'edit.dart';
import 'password.dart';
import 'profile.dart';

class CreatorProfileScreen extends StatefulWidget {
  const CreatorProfileScreen({super.key});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  PageController pageController = PageController();

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      onModelReady: (a) {
        a.getPosts(type: '');
      },
      builder: (_, PostViewModel model, __) => Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            backgroundColor: context.bgColor,
            border: Border.all(color: context.bgColor),
            trailing: Padding(
              padding: EdgeInsets.only(right: 25.h, top: 15.h),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        backgroundColor: context.sheetBG,
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.h),
                            topLeft: Radius.circular(50.h),
                          ),
                        ),
                        builder: (c) {
                          return const SettingsDialog();
                        },
                      );
                      setState(() {});
                    },
                    child: Image.asset(
                      'setting'.png,
                      height: 24.h,
                      color: context.textColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          child: NestedScrollView(
            headerSliverBuilder: (_, __) => [
              SliverList.list(
                children: [
                  Container(
                    color: context.bgColor,
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.h),
                          child: Row(
                            children: [
                              UserImage(
                                size: 73.h,
                                radius: 73.h,
                                imageUrl: AppCache.getUser()?.user?.image,
                              ),
                              SizedBox(width: 18.h),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HexText(
                                      '@${AppCache.getUser()?.user?.username}',
                                      fontSize: 18.sp,
                                      align: TextAlign.center,
                                      color: context.primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    SizedBox(height: 4.h),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 38.0),
                                      child: HexText(
                                        '#${AppCache.getUser()?.user?.categories?.map((e) => e.name).join(', #')}',
                                        fontSize: 16.sp,
                                        color: context.textColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 34.h),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      HexText(
                                        '${AppCache.getUser()?.user?.followersCount}',
                                        fontSize: 16.sp,
                                        color: context.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      HexText(
                                        ' Creators',
                                        fontSize: 16.sp,
                                        color: context.textColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  HexText(
                                    'Follow',
                                    fontSize: 16.sp,
                                    color: AppColors.grey2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60.h),
                                child: VerticalDivider(
                                  color: const Color(0xffA0A0A0),
                                  width: 0,
                                  thickness: 1.h,
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      HexText(
                                        '${AppCache.getUser()?.user?.categories?.length}',
                                        fontSize: 16.sp,
                                        color: context.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      HexText(
                                        ' Topics',
                                        fontSize: 16.sp,
                                        color: context.textColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  HexText(
                                    'Following',
                                    fontSize: 16.sp,
                                    color: AppColors.grey2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
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
            body: model.busy
                ? Container(
                    height: 200.h,
                    alignment: Alignment.center,
                    child: const HexProgress(),
                  )
                : model.posts == null
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
                          ImageVideoAudioPV(model: model, index: 0),
                          ImageVideoAudioPV(model: model, index: 1),
                          ImageVideoAudioPV(model: model, index: 2),
                        ],
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

class ImageVideoAudioPV extends StatelessWidget {
  const ImageVideoAudioPV(
      {super.key, required this.model, required this.index});
  final PostViewModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 22.h) / 3;
    List<Post> posts = model.posts ?? [];
    String type = index == 0
        ? 'image'
        : index == 1
            ? 'video'
            : 'audio';
    posts = posts.where((e) => e.fileType == type).toList();
    return Container(
      color: context.bgColor,
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
      child: posts.isEmpty
          ? EmptyOne('${(type).toTitleCase()}s are Empty')
          : Wrap(
              spacing: 2.h,
              runSpacing: 2.h,
              children: posts
                  .map(
                    (e) => InkWell(
                      onTap: () async {
                        if (AppCache.getUser()?.user?.id == e.userId) {
                          push(context, MyPostDetailScreen(post: e));
                        } else {
                          Map? d = await push(context,
                              VerticalPageView(post: e, from: 'my-own'));

                          if (d == null) return;
                          if (d.containsKey('delete')) {
                            model.posts
                                ?.removeWhere((a) => a.id == d['delete']);
                            model.setBusy(false);
                          }
                        }
                      },
                      child: CachedNetworkImage(
                        imageUrl: e.coverImage ?? 'm',
                        height: width,
                        width: width,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Image.asset(
                          'placeholder'.png,
                          height: width,
                          width: width,
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (_, __, ___) => Image.asset(
                          'placeholder'.png,
                          height: width,
                          width: width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.sheetBG,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.h),
          topLeft: Radius.circular(50.h),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 40.h),
        physics: const ClampingScrollPhysics(),
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: HexText(
                  'Setting',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  align: TextAlign.center,
                  color: context.textColor,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 25.h),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'close'.png,
                      height: 24.h,
                      color: context.textColor,
                      width: 24.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          ListView.separated(
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
            itemCount: all.length,
            itemBuilder: (c, i) {
              return InkWell(
                onTap: () {
                  if (i == 3) {
                    AppCache.setDarkMode();
                    setState(() {});
                  } else if (i == 5) {
                    showModalBottomSheet(
                      backgroundColor: context.sheetBG,
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.h),
                          topLeft: Radius.circular(50.h),
                        ),
                      ),
                      builder: (c) {
                        return const LogoutDialog();
                      },
                    );
                  } else {
                    push(context, all[i].last);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: i == 3 ? 15 : 25.h,
                    horizontal: 25.h,
                  ),
                  child: Row(
                    children: [
                      Image.asset('p${all[i][1]}'.png, height: 24.h),
                      SizedBox(width: 30.h),
                      HexText(
                        all[i].first,
                        fontSize: 16.sp,
                        color: all[i].first == 'Log out'
                            ? AppColors.red
                            : context.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                      SizedBox(width: 8.h),
                      i == 5
                          ? const SizedBox()
                          : i == 3
                              ? Switch.adaptive(
                                  value: AppCache.getDarkMode() == 'dark',
                                  onChanged: (a) {
                                    AppCache.setDarkMode();
                                    setState(() {});
                                  },
                                )
                              : Image.asset(
                                  'go'.png,
                                  height: 24.h,
                                  color: context.primary,
                                )
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }

  List<List> get all => [
        ['Edit Profile', 0, const EditProfileScreen()],
        ['Preferred Bible Translation', 1, const AllVersionScreen()],
        ['Bookmarks', 2, const BookmarksScreen()],
        ['Dark Mode', 6],
        ['Change Password', 3, const ChangePasswordScreen()],
        ['Log out', 4]
      ];
}

class MyPostDetailScreen extends StatelessWidget {
  const MyPostDetailScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.bgColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: context.primary),
        title: HexText(
          '@${AppCache.getUser()?.user?.username}',
          fontSize: 16.sp,
          color: context.primary,
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          HexText(
            'My Posts',
            fontSize: 14.sp,
            color: context.textColor,
          ),
          SizedBox(height: 20.h),
          Expanded(child: VerticalPageView(post: post, from: 'recent'))
        ],
      ),
    );
  }
}
