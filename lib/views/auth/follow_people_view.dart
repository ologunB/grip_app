import '../../core/vms/auth_vm.dart';
import '../widgets/hex_text.dart';

class FollowPeopleScreen extends StatefulWidget {
  const FollowPeopleScreen({super.key});

  @override
  State<FollowPeopleScreen> createState() => _FollowPeopleScreenState();
}

class _FollowPeopleScreenState extends State<FollowPeopleScreen> {
  List<int> selected = [];
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (m) => m.getCreators(),
      builder: (_, AuthViewModel model, __) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: model.busy
            ? const Center(child: HexProgress())
            : model.creators == null
                ? HexText(
                    'An error occurred, retry?',
                    fontSize: 32.sp,
                    color: AppColors.primary,
                    align: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  )
                : SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        HexText(
                          'Welcome to GRIP',
                          fontSize: 32.sp,
                          color: AppColors.primary,
                          align: TextAlign.center,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 5.h),
                        HexText(
                          'Follow users that you are\ninterested in',
                          fontSize: 16.sp,
                          color: AppColors.grey,
                          align: TextAlign.center,
                          fontWeight: FontWeight.normal,
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
                                bool contains = selected.contains(i);
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.h,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.h),
                                        child: Image.asset('user'.png),
                                      ),
                                    ),
                                    SizedBox(width: 17.h),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HexText(
                                          'Pastor Tobe',
                                          fontSize: 16.sp,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 8.h),
                                        HexText(
                                          '#prayer #fasting.....',
                                          fontSize: 12.sp,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(width: 8.h),
                                    BaseView<AuthViewModel>(
                                      builder: (_, AuthViewModel fModel, __) =>
                                          InkWell(
                                        onTap: () {
                                          fModel.follow('1');
                                          if (contains) {
                                            selected.remove(i);
                                          } else {
                                            selected.add(i);
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24.h, vertical: 12.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.h),
                                            border: Border.all(
                                                width: 1.h,
                                                color: const Color(0xff717171)),
                                            color: !contains
                                                ? Colors.transparent
                                                : AppColors.black,
                                          ),
                                          child: HexText(
                                            contains ? 'Following' : 'Follow',
                                            fontSize: 12.sp,
                                            color: contains
                                                ? Colors.white
                                                : const Color(0xff717171),
                                            align: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.h),
                          child: HexButton(
                            'Continue',
                            buttonColor: AppColors.black,
                            height: 60,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                            borderColor: Colors.transparent,
                            borderRadius: 10.h,
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
    );
  }
}
