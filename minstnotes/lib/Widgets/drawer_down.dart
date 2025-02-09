import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:minstnotes/Pages/config_page.dart';
import 'package:minstnotes/Pages/favoritos_page.dart';
import 'package:minstnotes/Pages/menu_notes.dart';
import 'package:minstnotes/Pages/perfil_page.dart';
//import 'package:minstnotes/Pages/menu_notes_page.dart';
//import 'package:minstnotes/Pages/favorites_page.dart';
//import 'package:minstnotes/Pages/settings_page.dart';
//import 'package:minstnotes/Pages/profile_page.dart';

class DrawerDown extends StatefulWidget {
  const DrawerDown({super.key});

  @override
  State<DrawerDown> createState() => _DrawerDownState();
}

class _DrawerDownState extends State<DrawerDown> {
  final PageController _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  final List<Widget> _pages = [
    const MenuNotesPage(),
    const FavoritosPage(),
    const ConfigPage(),
    const PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: Colors.black87,
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 300,
        itemLabelStyle: const TextStyle(fontSize: 10),
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_filled, color: Colors.blueGrey),
            activeItem: Icon(Icons.home_filled, color: Colors.blueAccent),
            itemLabel: 'Notas',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.star, color: Colors.blueGrey),
            activeItem: Icon(Icons.star, color: Colors.blueAccent),
            itemLabel: 'Favoritos',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.settings, color: Colors.blueGrey),
            activeItem: Icon(Icons.settings, color: Colors.pink),
            itemLabel: 'Ajustes',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: Colors.blueGrey),
            activeItem: Icon(Icons.person, color: Colors.yellow),
            itemLabel: 'Perfil',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      ),
    );
  }
}
