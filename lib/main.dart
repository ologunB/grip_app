import 'package:hexcelon/views/auth/follow_people_view.dart';
import 'package:hexcelon/views/auth/onboard_view.dart';

import 'core/models/navigator.dart';
import 'core/storage/local_storage.dart';
import 'locator.dart';
import 'views/create/media.dart';
import 'views/home/user_layout.dart';
import 'views/widgets/hex_text.dart';

List<GlobalKey<NavigatorState>> navigatorKeys = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  await AppCache.init(); //Initialize Hive
  cameras = await availableCameras();

  await GlobalConfiguration().loadFromAsset('.config');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, builder) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grip',
          theme: ThemeData(
            fontFamily: 'Nova',
            colorScheme: const ColorScheme.dark(background: Colors.transparent),
            primaryColor: AppColors.primary,
            tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          navigatorKey: AppNavigator.navKey,
          home: AppCache.getUser() == null
              ? const OnboardScreen()
              : AppCache.getUser()?.user?.role == 'user'
                  ? const UserLayout()
                  : const FollowPeopleScreen(),
        ), // AgentMainLayout ClientMainLayout
      ),
    );
  }
}
