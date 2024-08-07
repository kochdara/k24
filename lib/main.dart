import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

Config config = Config();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khmer24',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: config.primaryAppColor.shade600,
            shadowColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white)
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: 'en',
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'en'),
        cardTheme: const CardTheme(color: Colors.white),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        }),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        physics: const ClampingScrollPhysics()
      ),
      home: const HomePage(title: 'Demo App'),
    );
  }
}
