import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/post_model.dart';
import '../../core/vms/post_vm.dart';
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
        color: AppColors.primary,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
              title: HexText(
                'Bookmarks',
                fontSize: 16.sp,
                color: AppColors.black,
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
                              color: AppColors.black,
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

                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 25.h),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4.h),
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
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 8.h),
                                          HexText(
                                            '${co?.description}',
                                            fontSize: 14.sp,
                                            color: AppColors.black,
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
                                      color: AppColors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
      ),
    );
  }
}
