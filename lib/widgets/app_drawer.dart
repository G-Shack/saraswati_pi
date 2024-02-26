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
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('H O M E'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StartPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('S E T  R A T E S'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SetRatesPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
