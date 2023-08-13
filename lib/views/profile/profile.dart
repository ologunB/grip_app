import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/auth/follow_topics_view.dart';

import '../auth/login_view.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'all_versions.dart';
import 'edit.dart';
import 'history.dart';
import 'password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserImage(
                size: 107.h,
                radius: 107.h,
                imageUrl: AppCache.getUser()?.user?.image,
              ),
              SizedBox(height: 8.h),
              HexText(
                '@${AppCache.getUser()?.user?.username}',
                fontSize: 16.sp,
                align: TextAlign.center,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 21.h),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            HexText(
                              '${AppCache.getUser()?.user?.followingCount}',
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            HexText(
                              ' Creators',
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        HexText(
                          'Following',
                          fontSize: 16.sp,
                          color: AppColors.grey200,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.h),
                      child: VerticalDivider(
                        color: const Color(0xffA0A0A0),
                        width: 0,
                        thickness: 1.h,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await push(context, const FollowTopicsScreen());
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              HexText(
                                '${AppCache.getUser()?.user?.categories?.length}',
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              HexText(
                                ' Topics',
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          HexText(
                            'Following',
                            fontSize: 16.sp,
                            color: AppColors.grey200,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 56.h),
              ListView.separated(
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
                itemCount: all.length,
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () async {
                      if (all[i].first == 'Log out') {
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
                            return const LogoutDialog();
                          },
                        );
                      } else {
                        await push(context, all[i].last);
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 25.h,
                        horizontal: 25.h,
                      ),
                      child: Row(
                        children: [
                          Image.asset('p$i'.png, height: 24.h),
                          SizedBox(width: 30.h),
                          HexText(
                            all[i].first,
                            fontSize: 16.sp,
                            color: all[i].first == 'Log out'
                                ? AppColors.red
                                : AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          const Spacer(),
                          SizedBox(width: 8.h),
                          if (i != 4) Image.asset('go'.png, height: 24.h)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<List> get all => [
        ['Edit Profile', const EditProfileScreen()],
        ['Preferred Bible Translation', const AllVersionScreen()],
        ['History', const HistoryScreen()],
        ['Change Password', const ChangePasswordScreen()],
        ['Log out']
      ];
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

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
                'Logout',
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
                child: Image.asset(
                  'close'.png,
                  height: 24.h,
                  width: 24.h,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: HexText(
            'Are you sure you want to logout?',
            fontSize: 16.sp,
            align: TextAlign.center,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        HexButton(
          'Logout',
          buttonColor: AppColors.black,
          height: 60,
          safeArea: false,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.white,
          borderColor: Colors.transparent,
          borderRadius: 10.h,
          onPressed: () {
            Navigator.pop(context);
            AppCache.clear();
            pushAndRemoveUntil(context, const LoginScreen());
          },
        ),
        SizedBox(height: 20.h),
        HexButton(
          'Cancel',
          buttonColor: AppColors.white,
          height: 55,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.red,
          borderColor: AppColors.grey,
          borderRadius: 10.h,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
