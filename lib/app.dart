import 'package:flutter/material.dart';

import 'models/app_tab.dart';
import 'screens/children_screen.dart';
import 'screens/home_screen.dart';
import 'screens/measurements_screen.dart';
import 'screens/reports_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/app_bottom_navigation.dart';

class KaderCekApp extends StatefulWidget {
  const KaderCekApp({super.key});

  @override
  State<KaderCekApp> createState() => _KaderCekAppState();
}

class _KaderCekAppState extends State<KaderCekApp> {
  AppTab _selectedTab = AppTab.home;

  void _selectTab(AppTab tab) {
    setState(() => _selectedTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KaderCek',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _selectedTab.index,
            children: [
              HomeScreen(onNavigate: _selectTab),
              const ChildrenScreen(),
              const MeasurementsScreen(),
              const ReportsScreen(),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavigation(
          selectedTab: _selectedTab,
          onSelected: _selectTab,
        ),
      ),
    );
  }
}
