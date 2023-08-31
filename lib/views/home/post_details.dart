import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:hexcelon/core/models/login_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/comment_model.dart';
import '../../core/models/post_model.dart';
import '../../core/storage/local_storage.dart';
import '../../core/vms/post_vm.dart';
import '../../core/vms/settings_vm.dart';
import '../create/create.dart';
import '../widgets/hex_text.dart';
import '../widgets/lib/voice_message_package.dart';
import '../widgets/user_image.dart';
import 'profile.dart';

class MediaItem extends StatefulWidget {
  const MediaItem({super.key, this.post});
  final Post? post;

  @override
  State<MediaItem> createState() => _MediaItemState();
}

class _MediaItemState extends State<MediaItem> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  @override
  void initState() {
    super.initState();

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
      customVideoPlayerSettings: const CustomVideoPlayerSettings(
        placeholderWidget: CircularProgressIndicator(),
        showSeekButtons: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    _customVideoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.post?.fileType == 'image'
          ? CachedNetworkImage(
              imageUrl: widget.post?.coverImage ?? 'm',
              fit: BoxFit.cover,
              placeholder: (_, __) => Image.asset(
                'placeholder'.png,
                fit: BoxFit.cover,
              ),
              errorWidget: (_, __, ___) => Image.asset(
                'placeholder'.png,
                fit: BoxFit.cover,
              ),
            )
          : widget.post?.fileType == 'audio'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VoiceMessage(
                      audioSrc:
                          'https://download.samplelib.com/mp3/sample-15s.mp3',
                      played: false,
                      me: true,
                      //  meFgColor: AppColors.primary,
                      meBgColor: Colors.transparent,
                      contactPlayIconBgColor: AppColors.white,
                      contactPlayIconColor: AppColors.primary,
                      onPlay: () {},
                      radius: 1,
                    ),
                  ],
                )
              : CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController,
                ),
    );
  }
}

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.post});

  final Post post;
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Post post;

  bool liked = false;
  bool bookmarked = false;
  StreamSubscription? sSub;

  @override
  void initState() {
    post = widget.post;
    if (settingsVM.currentPosts[post.id] != null) {
      post = settingsVM.currentPosts[post.id]!;
      liked = post.isLiked!;
      bookmarked = post.isBooked!;
    }
    sSub = settingsVM.outPosts.listen((event) {
      if (settingsVM.currentPosts[post.id] != null) {
        post = settingsVM.currentPosts[post.id]!;
        liked = post.isLiked!;
        bookmarked = post.isBooked!;
        return;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      onModelReady: (a) => a.getPostDetails(widget.post.id),
      builder: (_, PostViewModel model, __) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            MediaItem(post: post),
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
                            UserModel u = post.user!;

                            push(context, OtherProfileScreen(user: u));
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
                      Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.h)),
                        child: Column(
                          children: [
                            ...[
                              1,
                              2,
                              3,
                              4,
                              if (Utils.allBooks.keys
                                      .contains(post.bibleBook) &&
                                  int.tryParse(post.bibleChapter ?? '') != null)
                                5
                            ]
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
                                          if (bookmarked) {
                                            model.deleteBookmark(post.id);
                                          } else {
                                            model.addBookmark(post.id);
                                          }
                                          bookmarked = !bookmarked;
                                          setState(() {});
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
                                          model.likePost(post.id);

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
                                              return DevotionalDialog(
                                                  post: post);
                                            },
                                          );
                                        } else {}
                                      },
                                      borderRadius: BorderRadius.circular(10.h),
                                      child: Image.asset(
                                        e == 4 && liked
                                            ? 'like'.png
                                            : e == 2 && bookmarked
                                                ? 'bookmark'.png
                                                : 'v$e'.png,
                                        height: 26.h,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
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
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Utils.offKeyboard,
      child: BaseView<PostViewModel>(
        onModelReady: (m) => m.getComments(post.id),
        builder: (_, PostViewModel model, __) => Container(
          height: MediaQuery.of(context).size.height * .8,
          padding: MediaQuery.of(context).viewInsets,
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
                      child: const HexError(
                          text: 'Error occurred when getting\ncomments'),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50.h),
                        topLeft: Radius.circular(50.h),
                      ),
                      child: body(model)),
        ),
      ),
    );
  }

  Widget body(PostViewModel model) {
    return Stack(
      children: [
        ListView(
          controller: scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 25.h),
          physics: const ClampingScrollPhysics(),
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: HexText(
                    '${model.comments?.length ?? 'No'} comments',
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
                    child: Image.asset('close'.png, height: 20.h, width: 20.h),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            model.comments!.isEmpty
                ? ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Container(
                        height: 200.h,
                        alignment: Alignment.center,
                        child: HexText(
                          'There are no comments at the moment. Be the\nfirst to comment',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          align: TextAlign.center,
                          color: AppColors.black,
                        ),
                      )
                    ],
                  )
                : ListView.separated(
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemCount: model.comments!.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.only(bottom: 60.h),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (_, i) {
                      Comment c = model.comments!.values.toList()[i];
                      return item(c, model);
                    },
                  ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: SafeArea(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(right: 10.h, left: 10.h, bottom: 5.h),
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
                        if (controller.text.trim().isEmpty) {
                          return;
                        }
                        model.createComment({
                          'postId': post.id,
                          'comment': controller.text.trim(),
                        });
                        controller.clear();
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent + 60.h,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear,
                        );
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(30.h),
                      child: Image.asset('send'.png, height: 50.h),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget item(Comment c, PostViewModel cModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (c.user?.role == 'creator') {
              // push(context, OtherProfileScreen(user: c.user!));
            }
          },
          borderRadius: BorderRadius.circular(40.h),
          child: CircleAvatar(
            radius: 16.h,
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.h),
              child: UserImage(
                imageUrl: c.user?.image,
                size: 31.h,
                radius: 31.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 9.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HexText(
                '${c.user?.username}',
                fontSize: 13.sp,
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 5.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: HexText(
                      '${c.comment}',
                      fontSize: 13.sp,
                      color: AppColors.black,
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(width: 6.h),
                  HexText(
                    timeago.format(DateTime.parse(c.createdAt!),
                        locale: 'en_short'),
                    fontSize: 15.sp,
                    color: AppColors.grey,
                  ),
                ],
              ),
              SizedBox(height: 11.h),
            ],
          ),
        ),
        SizedBox(width: 20.h),
        Column(
          children: [
            BaseView<PostViewModel>(
              builder: (_, PostViewModel model, __) => InkWell(
                onTap: () {
                  model.likeComment(c.postId, c.id);
                  Comment? old = cModel.comments![c.id];
                  old?.isLike = !old.isLike!;
                  print(cModel.comments);
                  if (old!.isLike!) {
                    c.likesCount = (int.parse(c.likesCount!) + 1).toString();
                  } else {
                    c.likesCount = (int.parse(c.likesCount!) - 1).toString();
                  }
                  cModel.comments?.update(c.id!, (value) => old);
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(8.h),
                child: Image.asset(
                  (c.isLike! ? 'like' : 'v4').png,
                  height: 20.h,
                  color: c.isLike! ? null : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            HexText(
              '${c.likesCount ?? 0}',
              fontSize: 13.sp,
              color: AppColors.grey,
            ),
          ],
        )
      ],
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
                  verse: int.parse(post.bibleChapter!))
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
            buttonColor: AppColors.black,
            height: 55,
            safeArea: false,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            borderColor: AppColors.black,
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
                successSnackBar(context, 'Post has been deleted');
              }
            },
          ),
        )
      ],
    );
  }
}
