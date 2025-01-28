import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_e_commerce/core/features/main/cart/provider/cartProvider.dart';
import 'package:furniture_e_commerce/core/features/main/services/storage_service.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/provider/theme_provider.dart';
import 'package:furniture_e_commerce/core/routes/routes.dart';
import 'package:furniture_e_commerce/firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjector.init();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => MyAuthProvider()..startFetchUserData(context)),
        ChangeNotifierProvider(create: (context) => CartProvider()
        ..ensureCartDocumentExists()
        ..initializeCache()),
        ChangeNotifierProvider(
            create: (context) => ThemeModeProvider()..loadTheme()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    StorageService storageService = locator<StorageService>();
    return MaterialApp.router(
      title: 'RoomifyAR',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeModeProvider>(context).themeMode.copyWith(
            textTheme: GoogleFonts.robotoTextTheme(
              storageService.getData('isDarkMode') == false
                  ? Theme.of(context).textTheme
                  : Theme.of(context).primaryTextTheme,
            ),
          ),
      themeAnimationCurve: Curves.bounceInOut,
      routerConfig: router,
    );
  }
}


