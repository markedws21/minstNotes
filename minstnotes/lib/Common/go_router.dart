import 'package:go_router/go_router.dart';
import 'package:minstnotes/Pages/menu_notes.dart';
import 'package:minstnotes/Widgets/drawer_down.dart';
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
      name: '/drawer',
      path: '/drawer',
      builder: (context,state) {
        return const DrawerDown();
      }
    ),
    GoRoute(
      name: '/menu',
      path: '/menu',
      builder: (context,state) {
        return const MenuNotesPage();
      }
    ),
  ]
);