import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';
import 'add_subject_screen.dart';
import 'subject_list_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    final screens = const [
      AddSubjectScreen(),
      SubjectListScreen(),
      SummaryScreen(),
    ];

    final titles = const ['Add Subject', 'Subject List', 'Result Summary'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[navProvider.currentIndex]),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: IndexedStack(index: navProvider.currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) => navProvider.setIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
