import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minstnotes/Pages/menu_notes.dart';
import 'package:minstnotes/Widgets/splash_screen.dart';

final GoRouter routers = GoRouter(
  initialLocation: '/preview',
  routes: <RouteBase>[
    GoRoute(
      name: '/preview',
      path: '/preview',
      builder: (context,state) {
        return const SplashScreen();
      }
    ),
    GoRoute(
      name: '/menu',
      path: '/menu',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MenuNotesPage(),
      ),
    ),
  ]
);