import '../widgets/hex_text.dart';
import 'follow_people_view.dart';

class FollowTopicsScreen extends StatefulWidget {
  const FollowTopicsScreen({super.key});

  @override
  State<FollowTopicsScreen> createState() => _FollowTopicsScreenState();
}

class _FollowTopicsScreenState extends State<FollowTopicsScreen> {
  List<String> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
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
              'Select at least 5 topics to\npersonalise your feed',
              fontSize: 16.sp,
              color: AppColors.grey,
              align: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  children: [
                    Wrap(
                      spacing: 12.h,
                      runSpacing: 12.h,
                      children: topics.map(
                        (e) {
                          bool contains = selected.contains(e);
                          return InkWell(
                            onTap: () {
                              if (contains) {
                                selected.remove(e);
                              } else {
                                selected.add(e);
                              }
                              setState(() {});
                            },
                            child: Container(
                                height: 50.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: contains ? 10.h : 22.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.h),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        HexText(
                                          '#$e',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: contains
                                              ? Colors.white
                                              : const Color(0xff868686),
                                          align: TextAlign.center,
                                        ),
                                        if (contains)
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.h),
                                            child: Image.asset(
                                              'mark'.png,
                                              height: 16.h,
                                            ),
                                          )
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(height: 12.h),
                  ],
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
                onPressed: selected.length < 5
                    ? null
                    : () {
                        push(context, const FollowPeopleScreen());
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<String> get topics => [
      'Inspiration',
      'Love',
      'Peace',
      'Relationship',
      'Encouragement',
      'Prayer',
      'Validation',
      'Career',
      'Anxiety',
      'Rejection',
      'Praise',
      'Purpose',
      'Healing',
      'Money',
      'Self Control',
      'Fasting',
      'Joy',
      'Righteousness',
      'Breakthrough',
    ];
