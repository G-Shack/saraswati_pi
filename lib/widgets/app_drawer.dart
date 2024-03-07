import 'package:flutter/material.dart';
import 'package:saraswati_pi/pages/set_rates_page.dart';
import 'package:saraswati_pi/pages/start_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xEEEB1555),
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.note_alt_sharp,
              size: 38,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('H O M E'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const StartPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('S E T   R A T E S'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SetRatesPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
