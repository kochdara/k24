import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/accounts/profiles/profile_page.dart';
import 'package:k24/pages/chats/chat_page.dart';
import 'package:k24/pages/main/home.dart';
import 'package:k24/pages/notifys/notify_page.dart';
import 'package:k24/pages/posts/post_page.dart';

void main() {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
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
        fontFamily: 'kh',
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'kh'),
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
      // home: const HomePage(title: 'Khmer24'),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'Khmer24'),
        '/notify': (context) => const NotifyPage(),
        '/post': (context) => const PostProductPage(),
        '/chat': (context) => const ChatPageView(selectedIndex: 3),
        '/profile': (context) => const ProfilePage(selectedIndex: 4),
      },
    );
  }
}
