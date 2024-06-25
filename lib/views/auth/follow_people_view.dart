import 'package:hexcelon/views/widgets/user_image.dart';

import '../../core/models/login_model.dart';
import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/retry_widget.dart';

class FollowPeopleScreen extends StatefulWidget {
  const FollowPeopleScreen({super.key});

  @override
  State<FollowPeopleScreen> createState() => _FollowPeopleScreenState();
}

class _FollowPeopleScreenState extends State<FollowPeopleScreen> {
  List<UserModel> selected = [];
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (m) => m.getCreators(),
      builder: (_, AuthViewModel model, __) => Scaffold(
        backgroundColor: context.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: context.primary),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('auth-${context.themeName}-bg'.png),
              fit: BoxFit.cover,
            ),
          ),
          child: model.busy
              ? const Center(child: HexProgress())
              : model.creators == null
                  ? RetryItem(
                      onTap: () {
                        model.getCreators();
                      },
                    )
                  : SafeArea(
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          HexText(
                            'Welcome to GRIP',
                            fontSize: 28.sp,
                            fontFamily: context.transformaSans,
                            color: context.primary,
                            align: TextAlign.center,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 5.h),
                          HexText(
                            'Follow users that you are\ninterested in',
                            style: AppThemes.subHeading16.copyWith(
                              color: context.isLight
                                  ? AppColors.darkGrey
                                  : AppColors.white,
                            ),
                            align: TextAlign.center,
                          ),
                          SizedBox(height: 40.h),
                          Expanded(
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (overscroll) {
                                overscroll.disallowIndicator();
                                return true;
                              },
                              child: ListView.separated(
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 20.h),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    bottom: 20.h, right: 25.h, left: 25.h),
                                itemCount: model.creators!.length,
                                itemBuilder: (c, i) {
                                  return item(model.creators![i]);
                                },
                              ),
                            ),
                          ),
                          Container(
                            color: context.bgColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.h,
                              vertical: 20.h,
                            ),
                            child: HexButton(
                              'Continue',
                              buttonColor: AppColors.secondary,
                              height: 48,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.white,
                              borderRadius: 4.h,
                              onPressed: selected.isEmpty
                                  ? null
                                  : () {
                                      Navigator.pop(context);
                                    },
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  Widget item(UserModel user) {
    bool contains = selected.contains(user);
    Color color = context.isLight ? AppColors.secondary : AppColors.grey;
    return Row(
      children: [
        UserImage(size: 60.h, radius: 60.h, imageUrl: user.image),
        SizedBox(width: 17.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HexText(
                '${user.username}',
                fontSize: 16.sp,
                color: context.textColor,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 4.h),
              HexText(
                '${user.categories?.map((c) => '#${c.name?.toLowerCase()}').join(', ')}',
                fontSize: 12.sp,
                color: context.primary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 8.h),
        BaseView<AuthViewModel>(
          builder: (_, AuthViewModel fModel, __) => InkWell(
            onTap: () {
              if (contains) {
                fModel.unfollow(user.id);
                selected.remove(user);
              } else {
                fModel.follow(user.id);
                selected.add(user);
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.h),
                border: Border.all(width: 1.h, color: color),
                color: contains ? color : Colors.transparent,
              ),
              child: HexText(
                contains ? 'Following' : 'Follow',
                fontSize: 14.sp,
                color: contains ? Colors.white : color,
                align: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
