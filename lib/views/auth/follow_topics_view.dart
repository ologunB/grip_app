import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/auth/follow_people_view.dart';

import '../../core/models/category_model.dart';
import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';
import '../widgets/retry_widget.dart';

class FollowTopicsScreen extends StatefulWidget {
  const FollowTopicsScreen({super.key, this.previous});

  final List<String>? previous;
  @override
  State<FollowTopicsScreen> createState() => _FollowTopicsScreenState();
}

class _FollowTopicsScreenState extends State<FollowTopicsScreen> {
  List<String> selected = [];
  @override
  void initState() {
    List<String>? previous =
        AppCache.getUser()?.user?.categories?.map((e) => e.name!).toList();
    selected.addAll(widget.previous ?? previous ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool updateUser = widget.previous == null;
    return BaseView<AuthViewModel>(
      onModelReady: (m) => m.getCategories(),
      builder: (_, AuthViewModel model, __) => Scaffold(
        backgroundColor: context.bgColor,
        appBar: AppBar(
          backgroundColor: context.bgColor,
          elevation: 0,
          iconTheme: IconThemeData(color: context.primary),
        ),
        bottomNavigationBar: model.categories == null
            ? const SizedBox()
            : BaseView<AuthViewModel>(
                builder: (_, AuthViewModel cModel, __) => Container(
                  color: context.bgColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
                  child: HexButton(
                    updateUser ? 'Continue' : 'Update',
                    buttonColor: AppColors.secondary,
                    height: 48,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.white,
                    borderRadius: 4.h,
                    busy: cModel.busy,
                    onPressed: selected.length < 5
                        ? null
                        : () async {
                            if (updateUser) {
                              bool a =
                                  await cModel.update({'category': selected});
                              if (!a) return;
                              Navigator.pop(context, selected);
                              push(context, const FollowPeopleScreen());
                            } else {
                              Navigator.pop(context, selected);
                            }
                          },
                  ),
                ),
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
              : model.categories == null
                  ? RetryItem(
                      onTap: () {
                        model.getCategories();
                      },
                    )
                  : SafeArea(
                      child: ListView(
                        children: [
                          SizedBox(height: 20.h),
                          if (updateUser)
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
                            'Select at least 5 topics to\npersonalise your feed',
                            style: AppThemes.subHeading16.copyWith(
                              color: context.isLight
                                  ? AppColors.darkGrey
                                  : AppColors.grey,
                            ),
                            align: TextAlign.center,
                          ),
                          SizedBox(height: 40.h),
                          NotificationListener<OverscrollIndicatorNotification>(
                            onNotification:
                                (OverscrollIndicatorNotification overscroll) {
                              overscroll.disallowIndicator();
                              return true;
                            },
                            child: ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 25.h),
                              children: [
                                Wrap(
                                  spacing: 12.h,
                                  runSpacing: 12.h,
                                  children: model.categories!
                                      .map((e) => item(e))
                                      .toList(),
                                ),
                                SizedBox(height: 12.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  Widget item(Category e) {
    bool contains = selected.contains(e.name?.toLowerCase());

    return InkWell(
      onTap: () {
        if (contains) {
          selected.remove(e.name!.toLowerCase());
        } else {
          selected.add(e.name!.toLowerCase());
        }
        setState(() {});
      },
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          border: Border.all(
            width: 1.h,
            color: contains
                ? AppColors.primary
                : (context.isLight ? AppColors.darkGrey : AppColors.grey2),
          ),
          color: !contains ? Colors.transparent : AppColors.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HexText(
                  '#${e.name?.toTitleCase()}',
                  style: AppThemes.pillText.copyWith(
                      color: contains
                          ? AppColors.white
                          : (context.isLight
                              ? AppColors.black
                              : const Color(0xff868686))),
                  align: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
