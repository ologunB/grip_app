import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:hexcelon/core/models/login_model.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/comment_model.dart';
import '../../core/models/post_model.dart';
import '../../core/storage/local_storage.dart';
import '../../core/vms/post_vm.dart';
import '../../core/vms/settings_vm.dart';
import '../create/create.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'profile.dart';

class MediaItem extends StatefulWidget {
  const MediaItem({super.key, this.post});
  final Post? post;

  @override
  State<MediaItem> createState() => _MediaItemState();
}

class _MediaItemState extends State<MediaItem> {
  VideoPlayerController? videoPlayerController;
  CustomVideoPlayerController? customVideoPlayerController;
  ChewieAudioController? chewieAudioController;

  @override
  void initState() {
    super.initState();

    if (widget.post?.fileType == 'video') {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.post!.file!))
            ..initialize().then((value) => setState(() {}));
      customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController!,
        customVideoPlayerSettings: const CustomVideoPlayerSettings(
          placeholderWidget: CircularProgressIndicator(),
          showSeekButtons: true,
        ),
      );
    } else if (widget.post?.fileType == 'audio') {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.post!.file!))
            ..initialize().then((value) => setState(() {}));
      chewieAudioController = ChewieAudioController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.grey,
          handleColor: AppColors.white,
          bufferedColor: AppColors.primaryBG,
          playedColor: AppColors.primary,
        ),
        cupertinoProgressColors: ChewieProgressColors(
          backgroundColor: Colors.grey,
          handleColor: AppColors.white,
          bufferedColor: AppColors.primaryBG,
          playedColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
    customVideoPlayerController?.dispose();
    chewieAudioController?.dispose();
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
              ? ChewieAudio(
                  controller: chewieAudioController!,
                )
              : CustomVideoPlayer(
                  customVideoPlayerController: customVideoPlayerController!,
                ),
    );
  }
}

class VerticalPageView extends StatefulWidget {
  const VerticalPageView({super.key, required this.post, this.from});

  final Post post;
  final String? from;
  @override
  State<VerticalPageView> createState() => _VerticalPageViewState();
}

class _VerticalPageViewState extends State<VerticalPageView> {
  List<Post> all = [];

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    all.add(widget.post);
    currentPost = widget.post;
    _loadMoreContent();
    _pageController.addListener(() {
      if (_pageController.position.pixels ==
              _pageController.position.maxScrollExtent &&
          !busy) {
        _loadMoreContent();
      }
    });
  }

  late Post currentPost;
  bool busy = false;
  Future<void> _loadMoreContent() async {
    if (busy) return;
    busy = true;
    setState(() {});
    List<Post> newOnes =
        (await PostViewModel().getNextPosts(currentPost.id, widget.from)) ?? [];

    all.addAll(newOnes);
    busy = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (a) {
        if (a >= all.length) return;
        currentPost = all[a];
      },
      children: [
        ...all
            .map(
              (e) => PostDetailScreen(
                post: e,
                from: widget.from,
              ),
            )
            .toList(),
        Scaffold(
          body: busy
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.h,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 60.h, right: 24.h),
                            child: InkWell(
                              onTap: Navigator.of(context).pop,
                              child: Image.asset(
                                'close'.png,
                                height: 32.h,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 50.h,
                      ),
                      SizedBox(height: 20.h),
                      HexText(
                        'You are all caught up',
                        fontSize: 20.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.post, this.from});

  final Post post;
  final String? from;
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

  double initialSize = 0;

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
                        SizedBox(height: 5.h),
                        HexText(
                          '${post.description}',
                          fontSize: 13.sp,
                          color: AppColors.white,
                          maxLines: 3,
                          fontWeight: FontWeight.w500,
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
                                onTap: () async {
                                  dynamic d = await showModalBottomSheet(
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
                                  if (d == 'deleted') {
                                    Navigator.pop(context, {'delete': post.id});
                                  }
                                  if (d == 'edited') {
                                    Navigator.pop(context, {'edit': post});
                                  }
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
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
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
                                  (e) => IconButton(
                                    onPressed: () {
                                      if (e == 1) {
                                        if (post.link != null) {
                                          Share.share('${post.link}',
                                              subject: '${post.title}\n');
                                        }
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
                                    icon: e == 4
                                        ? LikeButton(
                                            onTap: (a) async {
                                              model.likePost(post.id);
                                              liked = !liked;
                                              setState(() {});
                                              if (liked) {
                                                print('vibrate');
                                                HapticFeedback.mediumImpact();
                                              }
                                              return Future.value(liked);
                                            },
                                            size: 26.h,
                                            isLiked: liked,
                                            likeBuilder: (_) {
                                              return Image.asset(
                                                liked ? 'like'.png : 'v4'.png,
                                                height: 26.h,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            e == 4 && liked
                                                ? 'like'.png
                                                : e == 2 && bookmarked
                                                    ? 'bookmark'.png
                                                    : 'v$e'.png,
                                            height: 26.h,
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
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              minChildSize: 0,
              snap: true,
              initialChildSize: initialSize,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.blue[100],
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                );
              },
            ),
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
          //  height: MediaQuery.of(context).size.height * .8,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .7,
          ),
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

  ScrollController controller2 = ScrollController();
  Widget body(PostViewModel model) {
    return Stack(
      children: [
        model.comments!.isEmpty
            ? Container(
                height: 400.h,
                alignment: Alignment.center,
                child: HexText(
                  'There are no comments at the moment. Be the\nfirst to comment',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  align: TextAlign.center,
                  color: AppColors.black,
                ),
              )
            : RawScrollbar(
                controller: controller2,
                thumbColor: AppColors.primary.withOpacity(.5),
                radius: const Radius.circular(8),
                crossAxisMargin: 2,
                thumbVisibility: true,
                child: ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemCount: model.comments!.length,
                  shrinkWrap: true,
                  controller: controller2,
                  reverse: true,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  padding: EdgeInsets.only(bottom: 40.h, top: 60.h),
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (_, i) {
                    Comment c = model.comments!.values.toList()[i];
                    return item(c, model);
                  },
                ),
              ),
        Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 12.h, bottom: 6.h),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          height: 8.h,
                          width: 70.h,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(12.h)),
                        ),
                        SizedBox(height: 10.h),
                        HexText(
                          '${model.comments?.length ?? 'No'} comments',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          align: TextAlign.center,
                          color: AppColors.black,
                        ),
                      ],
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
                        child:
                            Image.asset('close'.png, height: 20.h, width: 20.h),
                      ),
                    ),
                  ),
                ],
              ),
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
                        setState(() {});

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
        SizedBox(width: 24.h),
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
        SizedBox(width: 4.h),
        Column(
          children: [
            BaseView<PostViewModel>(
              builder: (_, PostViewModel model, __) => IconButton(
                onPressed: () {
                  model.likeComment(c.postId, c.id);
                  Comment? old = cModel.comments![c.id];
                  old?.isLike = !old.isLike!;
                  if (old!.isLike!) {
                    c.likesCount = (int.parse(c.likesCount!) + 1).toString();
                  } else {
                    c.likesCount = (int.parse(c.likesCount!) - 1).toString();
                  }
                  cModel.comments?.update(c.id!, (value) => old);
                  setState(() {});
                },
                icon: Image.asset(
                  (c.isLike! ? 'like' : 'v4').png,
                  height: 20.h,
                  color: c.isLike! ? null : Colors.grey,
                ),
              ),
            ),
            HexText(
              '${c.likesCount ?? 0}',
              fontSize: 13.sp,
              color: AppColors.grey,
            ),
          ],
        ),
        SizedBox(width: 10.h),
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
                Navigator.pop(context, 'deleted');
                successSnackBar(context, 'Post has been deleted');
              }
            },
          ),
        )
      ],
    );
  }
}
