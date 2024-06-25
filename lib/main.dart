import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcelon/views/auth/onboard_view.dart';

import 'core/models/navigator.dart';
import 'core/models/post_model.dart';
import 'core/storage/local_storage.dart';
import 'core/vms/settings_vm.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'views/create/media.dart';
import 'views/home/post_details.dart';
import 'views/home/user_layout.dart';
import 'views/widgets/hex_text.dart';

List<GlobalKey<NavigatorState>> navigatorKeys = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupLocator();
  await AppCache.init(); //Initialize Hive
  cameras = await availableCameras();

  await GlobalConfiguration().loadFromAsset('.config');
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    settingsVM.outMainBrightness.listen((e) {
      setState(() {});
    });
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    dynamicLinks.onLink.listen((dynamicLinkData) {
      Map<String, String> d = dynamicLinkData.link.queryParameters;
      Post p = Post.fromJson(jsonDecode(d['data']!));
      if (p.title == null) return;
      push(AppNavigator.navKey.currentContext!, PostDetailScreen(post: p));
    }).onError((_) {});
  }

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
              brightness: AppCache.getDarkMode() == 'dark'
                  ? Brightness.dark
                  : Brightness.light,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme:
                  GoogleFonts.interTextTheme(Theme.of(context).textTheme),
              //    colorScheme: const ColorScheme.dark(surface: Colors.transparent),
              primaryColor: AppColors.secondary,
              tabBarTheme: const TabBarTheme(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            navigatorKey: AppNavigator.navKey,
            home: AppCache.getUser() == null
                ? const OnboardScreen()
                : const UserLayout()),
      ),
    );
  }
}
