import '../../core/models/post_model.dart';
import '../../core/storage/local_storage.dart';
import '../../core/vms/post_vm.dart';
import '../bible/search.dart';
import '../home/post_details.dart';
import '../profile/all_versions.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'edit.dart';
import 'history.dart';
import 'password.dart';
import 'profile.dart';

class CreatorProfileScreen extends StatefulWidget {
  const CreatorProfileScreen({super.key});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen> {
  int index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      onModelReady: (a) {
        a.getPosts();
      },
      builder: (_, PostViewModel model, __) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: AppColors.primary),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 25.h, top: 10.h),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                backgroundColor: Colors.white,
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
                            child: Image.asset('category'.png, height: 24.h),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
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
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                                SizedBox(height: 4.h),
                                Padding(
                                  padding: const EdgeInsets.only(right: 38.0),
                                  child: HexText(
                                    '#${AppCache.getUser()?.user?.categories?.map((e) => e.name).join(', #')}',
                                    fontSize: 16.sp,
                                    color: AppColors.black,
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
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  HexText(
                                    ' Creators',
                                    fontSize: 16.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              HexText(
                                'Follow',
                                fontSize: 16.sp,
                                color: AppColors.grey200,
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
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  HexText(
                                    ' Topics',
                                    fontSize: 16.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              HexText(
                                'Following',
                                fontSize: 16.sp,
                                color: AppColors.grey200,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(children: [item(0), item(1), item(2)]),
                    Expanded(
                      child: model.busy
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
                                  controller: controller,
                                  onPageChanged: (a) {
                                    index = a;
                                    setState(() {});
                                  },
                                  children: [
                                    ImageVideoAudioPV(
                                      userPosts: model.posts,
                                      index: index,
                                    ),
                                    ImageVideoAudioPV(
                                      userPosts: model.posts,
                                      index: index,
                                    ),
                                    ImageVideoAudioPV(
                                      userPosts: model.posts,
                                      index: index,
                                    ),
                                  ],
                                ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget item(int i) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.jumpToPage(i),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Image.asset(
            'm$i${i == index ? 1 : 0}'.png,
            height: 24.h,
            width: 24.h,
          ),
        ),
      ),
    );
  }
}

class ImageVideoAudioPV extends StatelessWidget {
  const ImageVideoAudioPV({super.key, this.userPosts, required this.index});
  final List<Post>? userPosts;
  final int index;
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 55.h) / 3;
    List<Post> posts = userPosts ?? [];
    String type = index == 0
        ? 'image'
        : index == 1
            ? 'video'
            : 'audio';
    posts = posts.where((e) => e.fileType == type).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 8.h),
      child: posts.isEmpty
          ? empty('${(type).toTitleCase()}s are Empty')
          : Wrap(
              spacing: 2.h,
              runSpacing: 2.h,
              children: posts
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        if (AppCache.getUser()?.user?.id == e.userId) {
                          push(context, MyPostDetailScreen(post: e));
                        } else {
                          push(context, PostDetailScreen(post: e));
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

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                color: AppColors.black,
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
                if (all[i].first == 'Log out') {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
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
                  vertical: 25.h,
                  horizontal: 25.h,
                ),
                child: Row(
                  children: [
                    Image.asset('p$i'.png, height: 24.h),
                    SizedBox(width: 30.h),
                    HexText(
                      all[i].first,
                      fontSize: 16.sp,
                      color: all[i].first == 'Log out'
                          ? AppColors.red
                          : AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    SizedBox(width: 8.h),
                    if (i != 4)
                      Image.asset(
                        'go'.png,
                        height: 24.h,
                        color: Colors.black,
                      )
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 25.h),
      ],
    );
  }

  List<List> get all => [
        ['Edit Profile', const EditProfileScreen()],
        ['Preferred Bible Translation', const AllVersionScreen()],
        ['History', const HistoryScreen()],
        ['Change Password', const ChangePasswordScreen()],
        ['Log out']
      ];
}

class MyPostDetailScreen extends StatelessWidget {
  const MyPostDetailScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBG,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBG,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: HexText(
          '@${AppCache.getUser()?.user?.username}',
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
          SizedBox(height: 20.h),
          Expanded(child: PostDetailScreen(post: post))
        ],
      ),
    );
  }
}
