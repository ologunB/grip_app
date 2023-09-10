import 'package:hexcelon/views/bible/bible_home.dart';

import '../../core/storage/local_storage.dart';
import '../../main.dart';
import '../create/media.dart';
import '../profile/creator_profile.dart';
import '../profile/profile.dart';
import '../widgets/hex_text.dart';
import 'explore.dart';
import 'home.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  List<Widget> get screens => [
        const HomeScreen(),
        const BibleHome(),
        const ExploreScreen(),
        AppCache.getUser()?.user?.role != 'user'
            ? const CreatorProfileScreen()
            : const ProfileScreen()
      ];

  int currentIndex = 0;
  @override
  void initState() {
    navigatorKeys = List.generate(5, (index) => GlobalKey<NavigatorState>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens
            .map(
              (e) => Navigator(
                key: navigatorKeys[screens.indexOf(e)],
                onGenerateRoute: (settings) =>
                    MaterialPageRoute(builder: (context) => e),
              ),
            )
            .toList(),
      ),
      backgroundColor: AppColors.white,
      floatingActionButton: AppCache.getUser()?.user?.role == 'user'
          ? null
          : FloatingActionButton(
              onPressed: () {
                push(context, const ChooseMediaScreen(), true);
              },
              backgroundColor: AppColors.primary,
              child: Icon(Icons.add_rounded, size: 40.h, color: Colors.white),
            ),
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
          if (i == currentIndex) {
            navigatorKeys[i].currentState!.popUntil((route) => route.isFirst);
          } else {
            setState(() => currentIndex = i);
          }
        },
        items: [0, 1, 3, 4]
            .map(
              (a) => BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Image.asset(
                    'h${a}0'.png,
                    height: 24.h,
                    width: 24.h,
                    color: const Color(0xffB5B5B5),
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Image.asset(
                    'h${a}1'.png,
                    height: 24.h,
                    width: 24.h,
                    color: AppColors.black,
                  ),
                ),
                label: ['Home', 'Bible', '', 'Explore', 'Profile'][a],
              ),
            )
            .toList(),
      ),
    );
  }
}
