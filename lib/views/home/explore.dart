import '../../core/models/post_model.dart';
import '../../core/vms/post_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'home.dart';
import 'post_details.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      builder: (_, PostViewModel sModel, __) => BaseView<PostViewModel>(
        onModelReady: (a) => a.getPosts(type: 'explore'),
        builder: (_, PostViewModel model, __) => Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            titleSpacing: 20.h,
            toolbarHeight: 70.h,
            centerTitle: false,
            title: Padding(
              padding: EdgeInsets.only(top: 16.h),
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
                controller: controller,
                onTapOutside: (_) => Utils.offKeyboard(),
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
          ),
          body: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  return model.getPosts(type: 'explore');
                },
                color: AppColors.primary,
                child: ListView(
                  padding: EdgeInsets.all(25.h),
                  children: [
                    model.busy
                        ? model.posts != null
                            ? StaggeredGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 6.h,
                                crossAxisSpacing: 6.h,
                                children: model.posts!
                                    .map(
                                      (e) => ExploreItem(
                                        post: e,
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
                                child: const HexError(
                                    text: 'Error occurred getting posts'),
                              )
                            : model.posts!.isEmpty
                                ? Container(
                                    height: 200.h,
                                    alignment: Alignment.center,
                                    child: HexText(
                                      'There are no posts at the moment',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      align: TextAlign.center,
                                      color: AppColors.black,
                                    ),
                                  )
                                : StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 6.h,
                                    crossAxisSpacing: 6.h,
                                    children: model.posts!
                                        .map(
                                          (e) => ExploreItem(
                                            post: e,
                                            model: model,
                                          ),
                                        )
                                        .toList(),
                                  ),
                  ],
                ),
              ),
              if (controller.text.isNotEmpty) SearchBody(model: sModel),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreItem extends StatelessWidget {
  const ExploreItem({super.key, required this.post, required this.model});
  final PostViewModel model;

  final Post post;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Map? d =
            await push(context, VerticalPageView(post: post, from: 'explore'));

        if (d == null) return;
        if (d.containsKey('delete')) {
          model.posts?.removeWhere((e) => e.id == d['delete']);
          model.setBusy(false);
        }
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
