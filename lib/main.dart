import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'core/models/navigator.dart';
import 'core/models/post_model.dart';
import 'core/storage/local_storage.dart';
import 'locator.dart';
import 'views/auth/onboard_view.dart';
import 'views/create/media.dart';
import 'views/home/post_details.dart';
import 'views/home/user_layout.dart';
import 'views/widgets/hex_text.dart';

List<GlobalKey<NavigatorState>> navigatorKeys = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
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
              fontFamily: 'Nova',
              colorScheme:
                  const ColorScheme.dark(background: Colors.transparent),
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
                : const UserLayout()),
      ),
    );
  }
}
