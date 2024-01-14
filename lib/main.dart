import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kidsplanetadmin/utils/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/membership_users/presentation/pages/home_page.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInit();
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/images/logo-crop.png"),
      // title: Text(
      //   "KidsPlanet Newspaper Karad",
      //   style: TextStyle(
      //     fontSize: 25,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      loadingText: Text("Software by Ananta Technocore Pvt Ltd"),
      showLoader: true,
      logoWidth: 200,
      navigator: const MyHomePage(),
      loaderColor: Colors.red,
    );
  }
}
