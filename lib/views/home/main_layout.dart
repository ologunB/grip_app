import '../bible/all_versions.dart';
import '../create/media.dart';
import '../profile/creator_profile.dart';
import '../widgets/hex_text.dart';
import 'explore.dart';
import 'home.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> get screens => const [
        HomeScreen(),
        AllVersionScreen(),
        SizedBox(),
        ExploreScreen(),
        CreatorProfileScreen(),
      ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.black,
        unselectedItemColor: const Color(0xffB5B5B5),
        iconSize: 20.h,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Nova',
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Nova',
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffB5B5B5),
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (i) {
          if (i == 2) {
            push(context, const ChooseMediaScreen(), true);
            return;
          }
          currentIndex = i;
          setState(() {});
        },
        items: [0, 1, 2, 3, 4]
            .map(
              (i) => i == 2
                  ? BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Image.asset(
                          'h21'.png,
                          height: 40.h,
                          width: 40.h,
                        ),
                      ),
                      label: '')
                  : BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Image.asset(
                          'h${i}0'.png,
                          height: 24.h,
                          width: 24.h,
                          color: const Color(0xffB5B5B5),
                        ),
                      ),
                      activeIcon: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Image.asset(
                          'h${i}1'.png,
                          height: 24.h,
                          width: 24.h,
                          color: AppColors.black,
                        ),
                      ),
                      label: ['Home', 'Bible', '', 'Explore', 'Profile'][i],
                    ),
            )
            .toList(),
      ),
    );
  }
}
