import 'package:hexcelon/core/apis/base_api.dart';
import 'package:hexcelon/views/auth/follow_people_view.dart';

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        bottomNavigationBar: model.categories == null
            ? const SizedBox()
            : BaseView<AuthViewModel>(
                builder: (_, AuthViewModel cModel, __) => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.h),
                  child: HexButton(
                    updateUser ? 'Continue' : 'Update',
                    buttonColor: AppColors.black,
                    height: 60,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.white,
                    borderColor: Colors.transparent,
                    borderRadius: 10.h,
                    busy: cModel.busy,
                    onPressed: selected.length < 5
                        ? null
                        : () async {
                            if (updateUser) {
                              bool a =
                                  await cModel.update({'category': selected});
                              if (a) {
                                pushReplacement(
                                    context, const FollowPeopleScreen());
                              }
                            } else {
                              Navigator.pop(context, selected);
                            }
                          },
                  ),
                ),
              ),
        body: model.busy
            ? const Center(child: HexProgress())
            : model.categories == null
                ? RetryItem(
                    onTap: () {
                      model.getCreators();
                    },
                  )
                : SafeArea(
                    child: ListView(
                      children: [
                        SizedBox(height: 20.h),
                        if (updateUser)
                          HexText(
                            'Welcome to GRIP',
                            fontSize: 32.sp,
                            color: AppColors.primary,
                            align: TextAlign.center,
                            fontWeight: FontWeight.w700,
                          ),
                        SizedBox(height: 5.h),
                        HexText(
                          'Select at least 5 topics to\npersonalise your feed',
                          fontSize: 16.sp,
                          color: AppColors.grey,
                          align: TextAlign.center,
                          fontWeight: FontWeight.normal,
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
                                children: model.categories!.map(
                                  (e) {
                                    bool contains = selected.contains(e.name);
                                    return InkWell(
                                      onTap: () {
                                        if (contains) {
                                          selected.remove(e.name);
                                        } else {
                                          selected.add(e.name!);
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: contains ? 10.h : 22.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.h),
                                          border: Border.all(
                                            width: 1.h,
                                            color: contains
                                                ? AppColors.black
                                                : const Color(0xff868686),
                                          ),
                                          color: !contains
                                              ? Colors.transparent
                                              : AppColors.black,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                HexText(
                                                  '#${e.name}',
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: contains
                                                      ? Colors.white
                                                      : const Color(0xff868686),
                                                  align: TextAlign.center,
                                                ),
                                                if (contains)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.h),
                                                    child: Image.asset(
                                                      'mark'.png,
                                                      height: 16.h,
                                                    ),
                                                  )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
