import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:education_app/core/common/features/course/presentation/course_cubit.dart';
import 'package:education_app/core/common/screens/persistent_screen.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:education_app/features/home/presentation/views/home_screen.dart';
import 'package:education_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          // TODO(Place-Holder): Put HomeScreen or other screens
          child: BlocProvider(create: (_) => serviceLocator<CourseCubit>(), child: const HomeScreen()),
        ),
      ),
      child: const PersistentScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          // TODO(Place-Holder): Put HomeScreen or other screens
          child: const Placeholder(),
        ),
      ),
      child: const PersistentScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          // TODO(Place-Holder): Put HomeScreen or other screens
          child: const Placeholder(),
        ),
      ),
      child: const PersistentScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const ProfileScreen(),
        ),
      ),
      child: const PersistentScreen(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 3;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
