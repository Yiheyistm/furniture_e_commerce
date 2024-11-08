import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/features/splash/view/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

Future<void> main() async {
  // try {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } catch (errorMsg) {
  //   print("Error: $errorMsg");
  // }
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => AuthProvider()),
        // ChangeNotifierProvider(create: (context) => CartProvider()),
        // ChangeNotifierProvider(create: (context) => ThemeModeProvider()),
      ],
      child: const StartWidget(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Furniture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0FA965)),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}

class StartWidget extends StatelessWidget {
  const StartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(seconds: 3),
      builder: (context) => const MyApp(),
    );
  }
}
