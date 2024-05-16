import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:joloondooapp/pages/components/appstate.dart';
import 'package:joloondooapp/pages/main_page.dart';
import 'package:joloondooapp/pages/profile_page.dart';
import 'package:joloondooapp/pages/settings_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = _buildPages();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = _buildPages();
  }

  List<Widget> _buildPages() {
    final userId = Provider.of<AppState>(context, listen: false).userId;
    return [
      MainPage(userId: userId),
      ProfilePage(userId: userId),
      const SettingsPage(),
    ];
  }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      final userId = Provider.of<AppState>(context, listen: false).userId;
      _pages = [
        MainPage(userId: userId),
        ProfilePage(userId: userId),
        const SettingsPage(),
      ];
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final userId = Provider.of<AppState>(context, listen: false).userId;
  //   _pages = [
  //     MainPage(userId: userId),
  //     ProfilePage(userId: userId),
  //     const SettingsPage(),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/joloondoo.png'),
          ),
        ],
        backgroundColor: const Color(0xFF1a2a5e),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1a2a5e),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(child: Image.asset('assets/images/joloondoo.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 20),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/contactpage');
                    },
                    leading: const Icon(Icons.phone, color: Colors.white),
                    title: const Text('Contact us',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/aboutpage');
                    },
                    leading: const Icon(Icons.info, color: Colors.white),
                    title: const Text('About us',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: ListTile(
                leading: Icon(Icons.copyright, color: Colors.white),
                title: Text('All rights reserved 2024',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color(0xFF1a2a5e),
        animationDuration: const Duration(milliseconds: 400),
        onTap: (value) {
          navigateBottomBar(value);
        },
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
          Icon(Icons.settings, color: Colors.white)
        ],
      ),
    );
  }
}
