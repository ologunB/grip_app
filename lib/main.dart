import 'package:hexcelon/views/auth/onboard_view.dart';
import 'package:hexcelon/views/create/media.dart';
import 'package:hexcelon/views/home/main_layout.dart';

import 'core/models/navigator.dart';
import 'core/storage/local_storage.dart';
import 'locator.dart';
import 'views/widgets/hex_text.dart';

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
            primaryColor: AppColors.primary,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: AppNavigator.navKey,
          home: AppCache.getUser() == null
              ? const OnboardScreen()
              : const MainLayout(),
        ), // AgentMainLayout ClientMainLayout
      ),
    );
  }
}
