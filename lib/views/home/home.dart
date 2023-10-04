import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/core/models/login_model.dart';
import 'package:hexcelon/views/home/profile.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/post_model.dart';
import '../../core/vms/auth_vm.dart';
import '../../core/vms/post_vm.dart';
import '../create/media.dart';
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
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      builder: (_, PostViewModel sModel, __) => Scaffold(
          backgroundColor: AppColors.white,
          floatingActionButton: AppCache.getUser()?.user?.role == 'user'
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    push(context, const ChooseMediaScreen(), true);
                  },
                  backgroundColor: AppColors.primary,
                  child:
                      Icon(Icons.add_rounded, size: 40.h, color: Colors.white),
                ),
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            backgroundColor: AppColors.white,
            titleSpacing: 25.h,
            toolbarHeight: 70.h,
            title: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: CupertinoTextField(
                onTapOutside: (_) => Utils.offKeyboard(),
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
                controller: controller,
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.h),
                  border: Border.all(color: const Color(0xffE0E0E0)),
                ),
                maxLines: 1,
                minLines: 1,
                onChanged: (a) {
                  sModel.search(a);
                  setState(() {});
                },
              ),
            ),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
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
          body: Stack(
            children: [
              Column(
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
                          color: index == 0
                              ? Colors.black
                              : const Color(0xffC6C6C6),
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
                          color: index == 1
                              ? Colors.black
                              : const Color(0xffC6C6C6),
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
                          builder: (_, PostViewModel model, __) =>
                              RefreshIndicator(
                            onRefresh: () async {
                              return model.getPosts(
                                  type:
                                      'recent/${AppCache.getUser()?.user?.id}');
                            },
                            color: AppColors.primary,
                            child: body(model),
                          ),
                        ),
                        BaseView<PostViewModel>(
                          onModelReady: (a) => a.getPosts(type: 'recommended'),
                          builder: (_, PostViewModel model, __) =>
                              RefreshIndicator(
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
              if (controller.text.isNotEmpty) SearchBody(model: sModel),
            ],
          )),
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
                    children: model.posts!
                        .map(
                          (e) => HomeItem(
                            post: e,
                            from: ['recent', 'recommended'][index],
                            model: model,
                          ),
                        )
                        .toList(),
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
                    children: model.posts!
                        .map(
                          (e) => HomeItem(
                            post: e,
                            from: ['recent', 'recommended'][index],
                            model: model,
                          ),
                        )
                        .toList(),
                  )
      ],
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem(
      {super.key, required this.post, required this.from, required this.model});

  final Post post;
  final String from;
  final PostViewModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Map? d = await push(context, VerticalPageView(post: post, from: from));

        if (d == null) return;
        if (d.containsKey('delete')) {
          model.posts?.removeWhere((a) => a.id == d['delete']);
          model.setBusy(false);
        }
      },
      child: IntrinsicHeight(
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xff393939)],
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

class SearchBody extends StatefulWidget {
  const SearchBody({super.key, required this.model});
  final PostViewModel model;

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  late PostViewModel model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          model.busy
              ? Container(
                  height: 200.h,
                  alignment: Alignment.center,
                  child: const HexProgress(text: 'Searching'),
                )
              : model.searchResults == null
                  ? Container(
                      height: 200.h,
                      alignment: Alignment.center,
                      child: const HexError(
                          text: 'Error occurred searching posts'),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            SizedBox(width: 15.h),
                            TextButton(
                              onPressed: () {
                                setState(() => model.current = 0);
                              },
                              child: HexText(
                                'Posts',
                                fontSize: 20.sp,
                                color: model.current == 0
                                    ? Colors.black
                                    : const Color(0xffC6C6C6),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 10.h),
                            TextButton(
                              onPressed: () {
                                setState(() => model.current = 1);
                              },
                              child: HexText(
                                'Users',
                                fontSize: 20.sp,
                                color: model.current == 1
                                    ? Colors.black
                                    : const Color(0xffC6C6C6),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        model.current == 0
                            ? model.searchResults!.first.isEmpty
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 80.h),
                                    child: HexText(
                                      'Posts with query are empty',
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4.h,
                                    crossAxisSpacing: 4.h,
                                    children:
                                        (model.searchResults!.first as List)
                                            .map(
                                              (e) => HomeItem(
                                                post: e,
                                                from: 'recommended',
                                                model: model,
                                              ),
                                            )
                                            .toList(),
                                  )
                            : model.searchResults!.last.isEmpty
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 80.h),
                                    child: HexText(
                                      'Users with query are empty',
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : ListView.separated(
                                    separatorBuilder: (_, __) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      child: Divider(
                                        height: 0.h,
                                        thickness: 1.h,
                                        color: const Color(0xffE6E6E6),
                                      ),
                                    ),
                                    itemCount:
                                        model.searchResults!.last!.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (c, i) {
                                      UserModel? co =
                                          model.searchResults!.last[i];
                                      bool contains =
                                          model.following.contains(co!.id!);
                                      return InkWell(
                                        onTap: () {
                                          co.isFollow = contains;
                                          push(context,
                                              OtherProfileScreen(user: co));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.h),
                                          child: Row(
                                            children: [
                                              UserImage(
                                                size: 40.h,
                                                radius: 10.h,
                                                imageUrl: co.image,
                                              ),
                                              SizedBox(width: 12.h),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    HexText(
                                                      '${co.username}',
                                                      fontSize: 16.sp,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    HexText(
                                                      'Followers: ${co.followersCount ?? 0} Following: ${co.followingCount ?? 0}',
                                                      fontSize: 14.sp,
                                                      color: AppColors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 12.h),
                                              BaseView<AuthViewModel>(
                                                builder: (_, fModel, __) =>
                                                    InkWell(
                                                  onTap: () {
                                                    if (contains) {
                                                      fModel.unfollow(co.id);
                                                      model.following
                                                          .remove(co.id);
                                                    } else {
                                                      fModel.follow(co.id);
                                                      model.following
                                                          .add(co.id!);
                                                    }
                                                    setState(() {});
                                                    model.setBusy(false);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 24.h,
                                                            vertical: 12.h),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.h),
                                                      border: Border.all(
                                                          width: 1.h,
                                                          color: const Color(
                                                              0xff717171)),
                                                      color: !contains
                                                          ? Colors.transparent
                                                          : AppColors.black,
                                                    ),
                                                    child: HexText(
                                                      contains
                                                          ? 'Following'
                                                          : 'Follow',
                                                      fontSize: 12.sp,
                                                      color: contains
                                                          ? Colors.white
                                                          : const Color(
                                                              0xff717171),
                                                      align: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ],
                    )
        ],
      ),
    );
  }
}
