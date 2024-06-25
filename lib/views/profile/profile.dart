import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/auth/follow_topics_view.dart';

import '../auth/login_view.dart';
import '../widgets/hex_text.dart';
import '../widgets/user_image.dart';
import 'all_versions.dart';
import 'bookmarks.dart';
import 'edit.dart';
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
      backgroundColor: context.bgColor,
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
                color: context.primary,
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
                              color: context.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            HexText(
                              ' Creators',
                              fontSize: 16.sp,
                              color: context.textColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        HexText(
                          'Following',
                          fontSize: 16.sp,
                          color: AppColors.grey2,
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
                                color: context.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              HexText(
                                ' Topics',
                                fontSize: 16.sp,
                                color: context.textColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          HexText(
                            'Following',
                            fontSize: 16.sp,
                            color: AppColors.grey2,
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
                      if (i == 3) {
                        AppCache.setDarkMode();
                        setState(() {});
                      } else if (i == 5) {
                        showModalBottomSheet(
                          backgroundColor: context.sheetBG,
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
                        vertical: i == 3 ? 15 : 25.h,
                        horizontal: 25.h,
                      ),
                      child: Row(
                        children: [
                          Image.asset('p${all[i][1]}'.png, height: 24.h),
                          SizedBox(width: 30.h),
                          HexText(
                            all[i].first,
                            fontSize: 16.sp,
                            color: all[i].first == 'Log out'
                                ? AppColors.red
                                : context.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          const Spacer(),
                          SizedBox(width: 8.h),
                          i == 5
                              ? const SizedBox()
                              : i == 3
                                  ? Switch.adaptive(
                                      value: AppCache.getDarkMode() == 'dark',
                                      onChanged: (a) {
                                        AppCache.setDarkMode();
                                        setState(() {});
                                      },
                                    )
                                  : Image.asset(
                                      'go'.png,
                                      height: 24.h,
                                      color: context.primary,
                                    )
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
        ['Edit Profile', 0, const EditProfileScreen()],
        ['Preferred Bible Translation', 1, const AllVersionScreen()],
        ['Bookmarks', 2, const BookmarksScreen()],
        ['Dark Mode', 6],
        ['Change Password', 3, const ChangePasswordScreen()],
        ['Log out', 4]
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
                color: context.textColor,
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
                  color: context.textColor,
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
            color: context.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        HexButton(
          'Logout',
          buttonColor: AppColors.secondary,
          height: 48,
          safeArea: false,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.white,
          borderRadius: 4.h,
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
          height: 48,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.red,
          borderColor: AppColors.grey,
          borderRadius: 4.h,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
