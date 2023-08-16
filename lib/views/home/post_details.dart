import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/comment_model.dart';
import '../../core/models/post_model.dart';
import '../../core/storage/local_storage.dart';
import '../../core/vms/post_vm.dart';
import '../create/create.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'profile.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.post});

  final Post post;
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Post post;
  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      builder: (_, PostViewModel model, __) => Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xff280E40)],
                stops: [0.0, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.srcATop,
              child: CachedNetworkImage(
                imageUrl: post.coverImage ?? 'm',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                placeholder: (_, __) => Image.asset(
                  'placeholder'.png,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                errorWidget: (_, __, ___) => Image.asset(
                  'placeholder'.png,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.h, right: 25.h, bottom: 50.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            push(context, OtherProfileScreen(user: post.user!));
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30.h,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.h),
                                  child: UserImage(
                                    imageUrl: post.user?.image,
                                    size: 58.h,
                                    radius: 39.h,
                                  ),
                                ),
                              ),
                              SizedBox(width: 9.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HexText(
                                    '${post.user?.username}',
                                    fontSize: 20.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 1.h),
                                  HexText(
                                    timeago.format(
                                        DateTime.parse(post.createdAt!)),
                                    fontSize: 15.sp,
                                    color: AppColors.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 27.h),
                        HexText(
                          '${post.title}',
                          fontSize: 15.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 22.h),
                        if (post.fileType == 'video') Image.asset('slide'.png)
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      AppCache.getUser()?.user?.id == post.userId
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top +
                                      34.h),
                              child: InkWell(
                                onTap: () {
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
                                      return EditPostDialog(post: post);
                                    },
                                  );
                                },
                                child: Image.asset('v0'.png, height: 32.h),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top +
                                      34.h),
                              child: InkWell(
                                onTap: Navigator.of(context).pop,
                                child: Image.asset(
                                  'close'.png,
                                  height: 32.h,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      const Spacer(),
                      ...[1, 2, 3, 4, if (post.bibleBook != null) 5, 6]
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: InkWell(
                                onTap: () {
                                  if (e == 1) {
                                    Share.share('${post.title}',
                                        subject:
                                            '${post.description}\n\n ${post.file}');
                                  } else if (e == 2) {
                                    model.bookmark(post.id);
                                  } else if (e == 3) {
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
                                        return CommentsDialog(post: post);
                                      },
                                    );
                                  } else if (e == 4) {
                                    if (liked) {
                                      model.unlikePost(post.id);
                                    } else {
                                      model.likePost(post.id);
                                    }
                                    liked = !liked;
                                    setState(() {});
                                  } else if (e == 5) {
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
                                        return DevotionalDialog(post: post);
                                      },
                                    );
                                  } else {}
                                },
                                child: Image.asset(
                                  e == 4 && liked ? 'like'.png : 'v$e'.png,
                                  height: 26.h,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      SizedBox(height: 20.h),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool liked = false;
}

class CommentsDialog extends StatefulWidget {
  const CommentsDialog({super.key, required this.post});

  final Post post;
  @override
  State<CommentsDialog> createState() => _CommentsDialogState();
}

class _CommentsDialogState extends State<CommentsDialog> {
  late Post post;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  List<int> selected = [];

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      onModelReady: (m) => m.getComments(post.id),
      builder: (_, PostViewModel model, __) => Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .8),
        child: model.busy
            ? Container(
                height: 200.h,
                alignment: Alignment.center,
                child: const HexProgress(),
              )
            : model.comments == null
                ? Container(
                    height: 200.h,
                    alignment: Alignment.center,
                    child: HexText(
                      'Error occurred getting comments',
                      color: AppColors.red,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : model.comments!.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: HexText(
                          'There are no comments at the moment. Be the\nfirst to comment',
                          fontSize: 14.sp,
                          align: TextAlign.center,
                          color: AppColors.black,
                        ),
                      )
                    : ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 25.h),
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: HexText(
                                  '${model.comments?.length} comments',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  align: TextAlign.center,
                                  color: AppColors.black,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset('close'.png,
                                      height: 20.h, width: 20.h),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.h),
                          ListView.separated(
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemCount: model.comments!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (_, i) {
                              Comment c = model.comments![i];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 16.h,
                                    backgroundColor: Colors.white,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.h),
                                      child: Image.asset(
                                        'placeholder'.png,
                                        height: 31.h,
                                        width: 31.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 9.h),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HexText(
                                          'martini_rond',
                                          fontSize: 13.sp,
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: HexText(
                                                '${c.name}',
                                                fontSize: 13.sp,
                                                color: AppColors.black,
                                                maxLines: 4,
                                              ),
                                            ),
                                            SizedBox(width: 6.h),
                                            HexText(
                                              '22h',
                                              fontSize: 15.sp,
                                              color: AppColors.grey,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 11.h),
                                        Row(
                                          children: [
                                            HexText(
                                              'View replies (4)',
                                              fontSize: 13.sp,
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            RotatedBox(
                                              quarterTurns: 1,
                                              child: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 16.h,
                                                color: AppColors.grey,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30.h),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          int id = post.id!;
                                          if (selected.contains(id)) {
                                            model.unlikeComment(id);
                                            selected.remove(id);
                                          } else {
                                            model.likeComment(id);
                                            selected.add(id);
                                          }
                                          setState(() {});
                                        },
                                        child: Image.asset('like'.png,
                                            height: 18.h),
                                      ),
                                      SizedBox(height: 5.h),
                                      HexText(
                                        '8098',
                                        fontSize: 13.sp,
                                        color: AppColors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 25.h),
                          SafeArea(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CupertinoTextField(
                                    padding: EdgeInsets.all(15.h),
                                    placeholderStyle: TextStyle(
                                      fontFamily: 'Nova',
                                      fontSize: 14.sp,
                                      color: AppColors.grey,
                                    ),
                                    placeholder: 'Leave a comment',
                                    controller: controller,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xffE0E0E0),
                                        width: 1.h,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.h),
                                InkWell(
                                  onTap: () async {
                                    bool bb = await model.createComment({
                                      'message': controller.text,
                                    });
                                    if (bb) {}
                                  },
                                  child: Image.asset('send'.png, height: 50.h),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }
}

class DevotionalDialog extends StatelessWidget {
  const DevotionalDialog({super.key, required this.post});

  final Post post;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.h),
      physics: const ClampingScrollPhysics(),
      children: [
        Stack(
          children: [
            HexText(
              'Study Devotional Message',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              color: AppColors.black,
            ),
            Align(
              alignment: Alignment.centerRight,
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
          ],
        ),
        SizedBox(height: 30.h),
        HexText(
          '${post.bibleBook} ${post.bibleChapter}:${post.bibleVerse}',
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 12.h),
        HexText(
          objectbox
              .getOneVerse(post.bibleBook!, int.parse(post.bibleChapter!),
                  verse: int.parse(post.bibleVerse!))
              .text,
          fontSize: 14.sp,
          color: AppColors.black,
        ),
        SizedBox(height: 150.h),
      ],
    );
  }
}

class EditPostDialog extends StatelessWidget {
  const EditPostDialog({super.key, required this.post});

  final Post post;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.h),
      physics: const ClampingScrollPhysics(),
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: HexText(
                'Post',
                fontSize: 14.sp,
                align: TextAlign.center,
                color: AppColors.black,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
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
          ],
        ),
        SizedBox(height: 50.h),
        BaseView<PostViewModel>(
          builder: (_, PostViewModel model, __) => HexButton(
            'Edit Post',
            buttonColor: AppColors.primary,
            height: 55,
            safeArea: false,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.primary,
            borderRadius: 10.h,
            busy: model.busy,
            onPressed: () async {
              dynamic data = await push(context, CreatePostScreen(post: post));
              if (data != null) {
                bool a = await model.updatePost(post.id, data);
                if (a) {
                  Navigator.pop(context);
                  successSnackBar(context, 'Post has been updated');
                }
              }
            },
          ),
        ),
        SizedBox(height: 20.h),
        BaseView<PostViewModel>(
          builder: (_, PostViewModel model, __) => HexButton(
            'Delete Post',
            buttonColor: AppColors.white,
            height: 55,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.red,
            borderColor: AppColors.grey,
            borderRadius: 10.h,
            busy: model.busy,
            onPressed: () async {
              bool a = await model.deletePost(post.id);
              if (a) {
                Navigator.pop(context);
                successSnackBar(context, 'Post has been updated');
              }
            },
          ),
        )
      ],
    );
  }
}
