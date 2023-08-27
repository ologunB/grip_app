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
          return model.getNotifications();
        },
        color: AppColors.primary,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: HexText(
              'Notifications',
              fontSize: 20.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: const IconThemeData(color: AppColors.primary),
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
                            Image.asset('empty'.png, height: 150.h),
                            Row(children: [SizedBox(height: 20.h)]),
                            HexText(
                              'No Notification',
                              fontSize: 28.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              align: TextAlign.center,
                            ),
                            SizedBox(height: 15.h),
                            HexText(
                              'You do not have any notification\nat this time',
                              fontSize: 16.sp,
                              color: AppColors.black,
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
                                padding: EdgeInsets.symmetric(vertical: 25.h),
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
                                          fontSize: 16.sp,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 5.h),
                                        HexText(
                                          timeago.format(
                                              DateTime.parse(co!.createdAt!)),
                                          fontSize: 14.sp,
                                          color: AppColors.black,
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
