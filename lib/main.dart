import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cod_forge/core/widgets/bottom_nav.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/category/category_screen.dart';
import 'screens/category/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}


final bottomNavIndexProvider = StateProvider<int>((ref) => 2);


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final screens = const [
      HomeScreen(),
      CartScreen(),
      CategoryScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ];

    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) => ref.read(bottomNavIndexProvider.notifier).state = index,
        ),
      ),
    );
  }
}
