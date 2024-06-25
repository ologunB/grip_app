import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/post_model.dart';
import '../../core/vms/post_vm.dart';
import '../home/post_details.dart';
import '../widgets/hex_text.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      onModelReady: (a) => a.getBookmarks(),
      builder: (_, PostViewModel model, __) => RefreshIndicator(
        onRefresh: () async {
          return model.getBookmarks();
        },
        color: context.primary,
        child: Scaffold(
            backgroundColor: context.bgColor,
            appBar: AppBar(
              backgroundColor: context.bgColor,
              centerTitle: true,
              iconTheme: IconThemeData(color: context.primary),
              title: HexText(
                'Bookmarks',
                fontSize: 16.sp,
                color: context.textColor,
                fontWeight: FontWeight.w500,
              ),
              elevation: 0,
            ),
            body: model.busy
                ? Container(
                    height: 200.h,
                    alignment: Alignment.center,
                    child: const HexProgress(text: 'Getting posts'),
                  )
                : model.bookmarks == null
                    ? Container(
                        height: 200.h,
                        alignment: Alignment.center,
                        child: const HexError(
                            text: 'Error occurred getting posts'),
                      )
                    : model.bookmarks!.isEmpty
                        ? Center(
                            child: HexText(
                              'Empty Bookmarks',
                              fontSize: 16.sp,
                              color: context.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : ListView.separated(
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
                            itemCount: model.bookmarks!.length,
                            itemBuilder: (c, i) {
                              Post? co = model.bookmarks?[i];

                              return InkWell(
                                onTap: () {
                                  push(context, PostDetailScreen(post: co));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 25.h),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(4.h),
                                        child: CachedNetworkImage(
                                          imageUrl: co?.coverImage ?? 'm',
                                          fit: BoxFit.cover,
                                          height: 40.h,
                                          width: 40.h,
                                          placeholder: (_, __) => Image.asset(
                                            'placeholder'.png,
                                            fit: BoxFit.cover,
                                            height: 40.h,
                                            width: 40.h,
                                          ),
                                          errorWidget: (_, __, ___) =>
                                              Image.asset(
                                            'placeholder'.png,
                                            fit: BoxFit.cover,
                                            height: 40.h,
                                            width: 40.h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.h),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            HexText(
                                              '${co?.title}',
                                              fontSize: 16.sp,
                                              color: context.textColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(height: 8.h),
                                            HexText(
                                              '${co?.description}',
                                              fontSize: 14.sp,
                                              color: context.primary,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8.h),
                                      HexText(
                                        timeago.format(
                                            DateTime.parse(co!.createdAt!)),
                                        fontSize: 14.sp,
                                        color: context.primary,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
      ),
    );
  }
}
