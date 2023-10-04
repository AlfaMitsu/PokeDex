import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/src/features/home/views/mobile/landing_page.dart';
import 'package:pokedex/src/features/home/views/mobile/region_list/screens/region_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/regionListScreen': (context) => const RegionListScreen(),
      },
    );
  }
}
