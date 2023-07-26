import 'package:google_fonts/google_fonts.dart';
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

  await GlobalConfiguration().loadFromAsset('.config');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, builder) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grip',
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
          primaryColor: AppColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: AppNavigator.navKey,
        home: const MainLayout(),
      ), // AgentMainLayout ClientMainLayout
    );
  }
}
