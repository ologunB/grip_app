import 'package:timeago/timeago.dart' as timeago;

import '../../core/models/comment_model.dart';
import '../../core/vms/post_vm.dart';
import '../widgets/hex_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PostViewModel>(
      onModelReady: (a) => a.getNotifications(),
      builder: (_, PostViewModel model, __) => RefreshIndicator(
        onRefresh: () async {
          return await model.getNotifications();
        },
        color: AppColors.secondary,
        child: Scaffold(
          backgroundColor: context.bgColor,
          appBar: AppBar(
            backgroundColor: context.bgColor,
            elevation: 0,
            centerTitle: true,
            title: HexText(
              'Notifications',
              style: AppThemes.taskBarTitle.copyWith(color: context.textColor),
            ),
            iconTheme: IconThemeData(color: context.primary),
          ),
          body: model.busy
              ? Container(
                  height: 200.h,
                  alignment: Alignment.center,
                  child: const HexProgress(text: 'Getting notifications'),
                )
              : model.notifications == null
                  ? Container(
                      height: 200.h,
                      alignment: Alignment.center,
                      child: const HexError(
                          text: 'Error occurred getting notifications'),
                    )
                  : model.notifications!.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'empty'.png,
                              height: 150.h,
                              color: context.primary,
                            ),
                            Row(children: [SizedBox(height: 20.h)]),
                            HexText(
                              'No Notification',
                              style: AppThemes.header2
                                  .copyWith(color: context.primary),
                              align: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                            HexText(
                              'You do not have any\nnotification at this time',
                              style: AppThemes.subHeading16
                                  .copyWith(color: context.textColor),
                              align: TextAlign.center,
                            ),
                            SizedBox(height: 75.h),
                          ],
                        )
                      : ListView(
                          padding: EdgeInsets.symmetric(horizontal: 25.h),
                          children: [
                            SizedBox(height: 30.h),
                            ListView.separated(
                              separatorBuilder: (_, __) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Divider(
                                  height: 0.h,
                                  thickness: 1.h,
                                  color: const Color(0xffE6E6E6),
                                ),
                              ),
                              itemCount: model.notifications!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (c, i) {
                                NotificationModel? co = model.notifications?[i];
                                return Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HexText(
                                          '${co?.message}',
                                          style: AppThemes.profileNameL
                                              .copyWith(
                                                  color: context.textColor),
                                        ),
                                        SizedBox(height: 5.h),
                                        HexText(
                                          timeago.format(
                                              DateTime.parse(co!.createdAt!)),
                                          style: AppThemes.commentText
                                              .copyWith(color: context.primary),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
        ),
      ),
    );
  }
}
